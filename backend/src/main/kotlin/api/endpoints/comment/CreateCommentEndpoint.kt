package src.api.endpoints.comment

import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import src.api.endpoints.Endpoint
import src.api.responses.ErrorResponse
import src.data.CommentData
import src.data.Id
import src.database.PublicDb

//This class is temporarily identical to CommentData (until auth is implemented)
@Serializable
class CreateCommentArgs(private val postId: Id,
                        private val userId: Id,
                        private val comment: String){

    fun toCommentData() = CommentData(postId, userId, comment)
}

class CreateCommentEndpoint(private val publicDb: PublicDb) : Endpoint {

    override val path = "/createComment"

    override fun handle(jsonInput: String): String {
        val input = json.decodeFromString<CreateCommentArgs>(jsonInput)
        //TODO: token check
        val comment = publicDb.createComment(input.toCommentData())
            ?: return json.encodeToString(ErrorResponse.unknown())
        return json.encodeToString(comment.data)
    }
}