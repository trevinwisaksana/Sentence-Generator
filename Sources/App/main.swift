import Vapor
import VaporPostgreSQL

let drop = Droplet(); try drop.addProvider(VaporPostgreSQL.Provider)

drop.get("version") { request in
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No db connection"
    }
}

drop.resource("posts", PostController())

drop.run()
