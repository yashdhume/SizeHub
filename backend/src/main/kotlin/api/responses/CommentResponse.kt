package src.api.responses

import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import src.database.dbitems.Comment

@Serializable
class CommentResponse(val commentId: String,
                      val comment: String) {

    companion object{
        fun from(comment: Comment) = CommentResponse(comment.id, comment.data.comment)
    }

    fun toJson() = Json.encodeToString(this)
}