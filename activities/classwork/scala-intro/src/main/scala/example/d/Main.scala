package example.d

import java.util.UUID

import example.a.model.Timestamp
import example.d.model.Visitor

object Main {

  def older(v1: Visitor, v2: Visitor): Boolean =
    v1.createAt.seconds > v2.createAt.seconds

  def getAnonymousUser(age: Int): Visitor = Visitor.Anonymous(
    UUID.randomUUID().toString,
    Timestamp(age))
  val getUser: Int => Visitor = (age: Int) => Visitor.User(
    id = UUID.randomUUID().toString,
    email = "email@example.com",
    createAt = Timestamp(age)
  )
// First case: sbt "runMain example.d.Main 100 90"
  // Second case: sbt "runMain example.d.Main 100 900"
  def main(args: Array[String]): Unit = {
    val Array(firstAge, secondAge) = args

    val a = getAnonymousUser(firstAge.toInt)
    val b = getUser(secondAge.toInt)

    //print older user
    if (older(a,b)) a.show() else b.show()
  }

}
