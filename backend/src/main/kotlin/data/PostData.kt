package src.data

class PostData(val userId: Id,
               val itemId: Id,
               val userMeasurementsData: UserMeasurementsData,
               val photoUrls: List<String>,
               val comment: String)