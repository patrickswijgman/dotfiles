function init()
  app.events:on("aftercommand", function(ev)
    if ev.name == "SaveFile" or ev.name == "SaveFileAs" then
      local sprite = app.sprite
      local path = sprite.filename
      local basePath = path:match("^(.+)%..+$") or path

      app.command.ExportSpriteSheet({
        ui = false,
        askOverwrite = false,
        type = SpriteSheetType.PACKED,
        textureFilename = basePath .. ".png",
        dataFilename = basePath .. ".json",
        dataFormat = SpriteSheetDataFormat.JSON_ARRAY,
      })
    end
  end)
end

function exit()
end
