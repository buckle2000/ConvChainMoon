export log = require "log"
-- export log = {
--   trace: ->
--   debug: ->
--   info: ->
-- }
Generator = require "convchain.Generator"
Array2D = require "convchain.Array2D"


img = love.graphics.newImage('seed.png')
imgdata = img\getData!
sample = Array2D(img\getDimensions!)

for x=0,sample.height-1
  for y=0,sample.width-1
    r,g,b,a = imgdata\getPixel x, y
    if r == 0
      sample\set x, y, 0
    else
      sample\set x, y, 1

receptorSize = 3
temperature = 3.4

iteration = 0
gen = Generator sample, receptorSize, temperature, 64,64

love.keyboard.setKeyRepeat true

love.keypressed = (key) ->
  switch key
    when 'i'
      gen\iterate!
      iteration += 1
      love.window.setTitle(iteration)
    when 's'
      gen\iterateRandom!
    when 'r'
      gen\randomizeField!

love.draw = ->
  for x=0,gen.width-1
    for y=0,gen.height-1
      thing = gen.field\get x,y
      if thing == 1
        love.graphics.rectangle 'fill', x * 8, y * 8, 8,8
