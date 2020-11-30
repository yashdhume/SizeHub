package src.server

import io.ktor.routing.*
import src.api.endpoints.KtorGetHandler
import src.api.endpoints.KtorPostHandler
import src.api.endpoints.comment.CreateCommentEndpoint
import src.api.endpoints.comment.GetRepliesEndpoint
import src.api.endpoints.post.CreatePostEndpoint
import src.database.PublicDb

class Router(publicDb: PublicDb) {

    private val ktorGetHandler = KtorGetHandler()
    private val ktorPostHandler = KtorPostHandler()

    private val getEndpoints = listOf(
        GetRepliesEndpoint(publicDb)
    )
    private val postEndpoints = listOf(
        CreatePostEndpoint(publicDb),
        CreateCommentEndpoint(publicDb)
    )

    val setup: Routing.() -> Unit = {
        getEndpoints.forEach { endpoint ->
            get(endpoint.path) { ktorGetHandler.handle(context, endpoint) }
        }
        postEndpoints.forEach { endpoint ->
            post(endpoint.path) { ktorPostHandler.handle(context, endpoint) }
        }
    }
}