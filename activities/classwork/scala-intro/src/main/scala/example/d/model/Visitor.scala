package example.d.model

import example.a.model.Timestamp

sealed trait Visitor {
  def id: String
  def createAt: Timestamp

  def getAgeInSeconds: Int = createAt.seconds

  def getAge: Int = createAt.seconds
  def show(): Unit = this match{
    case Visitor.Anonymous(id, createAt) =>
      println(s"Anonymous user with id $id")
    case Visitor .User(id, email, createAt)=>
      println(s"User with email $email")
  }

  def getEmail: Option[String]
}

object Visitor{
  final case class Anonymous(id: String,createAt: Timestamp) extends Visitor{
    override def getEmail: Option[String] = None
  }
  final case class User(id: String, email: String,createAt: Timestamp) extends Visitor{
    override def getEmail: Option[String] = Some(email)
  }
}
