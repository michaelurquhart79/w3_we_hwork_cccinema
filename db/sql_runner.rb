require("pg")

class SqlRunner

  def self.run(sql, values = [])
    begin
      # connect to db
      db = PG.connect({dbname: "cccinema", host: "localhost"})
      # prepare statement
      db.prepare("query", sql)
      # results = exec prepared statement
      result = db.exec_prepared("query", values)
    ensure
      # close db
      db.close() if db != nil
    end
    return result
  end

end
