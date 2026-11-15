local M = {}

local function reload_config()
  hl.exec_cmd("hyprctl reload")
end

function M.run()
  if running then return end
  running = true

  local names = {}
  local ok, monitors = pcall(hl.get_monitors)
  if ok and monitors then
    for _, m in ipairs(monitors) do names[#names + 1] = m.name end
  end

  local function step(i)
    local name = names[i]
    if not name then
      reload_config()
      running = false
      return
    end

    hl.monitor({ output = name, disabled = true })
    reload_config()
    step(i+1)
  end

  step(1)
end

-- Global, so it can also be run from a terminal: hyprctl eval "cycle_monitors()"
_G.cycle_monitors = M.run

return M
