package src.server

import io.ktor.application.*
import io.ktor.features.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.websocket.*

class Server {

    init {
        val port = System.getenv("PORT")?.toInt() ?: 3000
        val server = embeddedServer(Netty, port = port) {
            install(CORS) {
                method(HttpMethod.Options)
                method(HttpMethod.Get)
                method(HttpMethod.Post)
                method(HttpMethod.Put)
                method(HttpMethod.Delete)
                method(HttpMethod.Patch)
                allowCredentials = true
                anyHost()
                header("tokenId")
                header("tokenSecret")
                header(HttpHeaders.AccessControlAllowHeaders)
                header(HttpHeaders.AccessControlExposeHeaders)
                header(HttpHeaders.AccessControlRequestHeaders)
                header(HttpHeaders.ContentType)
                header(HttpHeaders.AccessControlAllowOrigin)
            }
            install(WebSockets)
            routing {
                get("/") { call.respond("Welcome to ... the Backend") }
            }
        }
        server.start(wait = true)
    }

}