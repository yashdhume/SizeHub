package src.jobs

import kotlinx.coroutines.runBlocking
import src.database.PublicDb
import src.database.dbitems.Post
import src.socket.trending.TrendingPageEndpoint

class TrendingPageUpdater(private val publicDb: PublicDb,
                          private val trendingPageEndpoint: TrendingPageEndpoint) {

    private val lastUpdate: Long = System.currentTimeMillis()
    private var latestPosts: List<Post> = listOf()

    private val postUpdateTime = 2 * 60 * 1000
    private val shouldUpdate get() = System.currentTimeMillis() > lastUpdate + postUpdateTime

    init{
        updatePosts()
    }

    fun start(){
        Thread {
            while(true){
                if(shouldUpdate){
                    updatePosts()
                }
                sendPost()
                Thread.sleep(1000)
            }
        }.start()
    }

    private fun updatePosts(){
        latestPosts = publicDb.posts.getLatestPosts(10)
    }

    private fun sendPost(){
        latestPosts.randomOrNull()?.let {
            runBlocking {
                trendingPageEndpoint.sendPost(it)
            }
        }
    }
}