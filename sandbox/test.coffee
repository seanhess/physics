init = ->
  console.log "HI"

  {extend} = _

  {b2Vec2} = Box2D.Common.Math
  {b2AABB} = Box2D.Collision
  {b2BodyDef, b2Body, b2FixtureDef, b2Fixture, b2World} = Box2D.Dynamics
  {b2MassData, b2PolygonShape, b2CircleShape} = Box2D.Collision.Shapes
  {b2DebugDraw} = Box2D.Dynamics
  {b2MouseJointDef} =  Box2D.Dynamics.Joints

  gravity = new b2Vec2 0, 0
  world = new b2World gravity, true

  fixture = extend new b2FixtureDef,
    density: 10.0
    friction: 0.0
    restitution: 0.9

init()
