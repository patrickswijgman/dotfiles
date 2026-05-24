function init()
  app.events:on("aftercommand", function(ev)
    if ev.name == "SaveFile" or ev.name == "SaveFileAs" then
      local sprite = app.sprite
      local path = sprite.filename
      local basePath = path:match("^(.+)%..+$") or path

      app.command.ExportSpriteSheet({
        type = SpriteSheetType.PACKED,
        textureFilename = basePath .. ".png",
        dataFilename = basePath .. ".json",
        dataFormat = SpriteSheetDataFormat.JSON_ARRAY,
        listTags = true,
        listLayers = true,
        listSlices = true,
        ui = false,
        askOverwrite = false,
      })
    end
  end)
end

function exit()
end
