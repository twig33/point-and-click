function startup()

  -- GAME WINDOW CONFIGURATION

  -- Window title
  love.window.setTitle("CAVERN")

  -- Window icon
  local icon = love.image.newImageData('img/oldHero.png')
  love.window.setIcon(icon)

  -- Game resolution
  --gameWidth = 1152
  --gameHeight = 768

  --scale = scale * offset

  --love.window.setMode(gameWidth * scale, gameHeight * scale, {fullscreen = false,
   --fullscreentype = "desktop", resizable = false, borderless = false,
    --vsync = true})


  -- GAME SETUP

  -- Global sound variable, game starts with it on
  soundOn = true

  -- Requires all global source files
  require("source/startup/main_require")
  getGlobals()

  -- Sets first map of the game
  --changeToMap("MainMenu")

  -- Start the music
  --soundManager:startMusic("menu")
end

-- This function resets all values after the game is completed
function reinit()
  gameStateInit()
  player.health = 0
end