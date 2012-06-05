init = ->
  console.log "HI"

  {extend} = _

  {b2Vec2} = Box2D.Common.Math
  {b2AABB} = Box2D.Collision
  {b2BodyDef, b2Body, b2FixtureDef, b2Fixture, b2World} = Box2D.Dynamics
  {b2MassData, b2PolygonShape, b2CircleShape} = Box2D.Collision.Shapes
  {b2DebugDraw} = Box2D.Dynamics
  {b2MouseJointDef} =  Box2D.Dynamics.Joints



  ## LIBRARY CODE ###################################################
  # body: type, position.x, position.y
  # fixture: density, friction, restitution, +shape
  # shape: really just a constructor, like circle or square

  squareShape = (w, h) ->
    square = new b2PolygonShape
    square.SetAsBox w, h
    return square

  circleShape = (radius) ->
    circle = new b2CircleShape radius

  body = (type, x, y) ->
    b = new b2BodyDef
    b.type = type
    return b

  point = (x, y) -> {x, y}

  fixture = (options) -> extend new b2FixtureDef, options

  staticBody = -> body b2Body.b2_staticBody
  dynamicBody = -> body b2Body.b2_dynamicBody

  # creates a new object
  create = (world, body, fixture, shape, position) ->
    fixture.shape = shape
    body.position = position
    world.CreateBody(body).CreateFixture(fixture)





  ## APPLICATION CODE ###############################################
  defaultFixture = extend new b2FixtureDef,
    density: 10.0
    friction: 0.0
    restitution: 0.9


  gravity = new b2Vec2 2, 4
  world = new b2World gravity, true

  # the fixture is the object's dimentions itself, but no position.
  fix = fixture
    density: 10.0
    friction: 0.0
    restitution: 0.9

  horizontal = squareShape 20, 2
  create world, staticBody(), fix, horizontal, point(10, 400 / 30 + 1.8)
  create world, staticBody(), fix, horizontal, point(10, -1.8)

  vertical = squareShape 2, 14
  create world, staticBody(), fix, vertical, point(-1.8, 13)
  create world, staticBody(), fix, vertical, point(21.8, 13)

  # create some (an) objects
  create world, dynamicBody(), fix, circleShape(0.2), point(5, 5)

  # debug draw
  debugDraw = new b2DebugDraw
  debugDraw.SetSprite document.getElementById("canvas").getContext("2d")
  debugDraw.SetDrawScale 30.0
  debugDraw.SetFillAlpha 0.5
  debugDraw.SetLineThickness 1.0
  debugDraw.SetFlags b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit
  world.SetDebugDraw debugDraw

  # update
  update = ->
    world.Step(1 / 60, 10, 10)
    world.DrawDebugData()
    world.ClearForces()

  setInterval update, 1000 / 60


# you can't compose that easily with defaults though!
# for example, it's not easy to just change the bounciness and use the default properties

init()
