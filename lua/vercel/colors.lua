local M = {}

---Raw Vercel color scales, see SCHEMA.md.
---Indexed by scale name and step: `colors.palette.red[900]`.
---@class VercelPalette
---@field gray table<integer, string>
---@field blue table<integer, string>
---@field amber table<integer, string>
---@field red table<integer, string>
---@field green table<integer, string>
---@field teal table<integer, string>
---@field purple table<integer, string>
---@field pink table<integer, string>
---@field background table<integer, string>

---@param theme "light" | "dark"
M.getColors = function(theme)
  local colors = {}
  local is_light = theme == "light" or vim.o.background == "light"
  if is_light then
    ---@type VercelPalette
    colors.palette = {
      gray = {
        [100] = "#f2f2f2",
        [200] = "#ebebeb",
        [300] = "#e6e6e6",
        [400] = "#ebebeb",
        [500] = "#c9c9c9",
        [600] = "#a8a8a8",
        [700] = "#8f8f8f",
        [800] = "#7d7d7d",
        [900] = "#4d4d4d",
        [1000] = "#171717",
      },
      blue = {
        [100] = "#f0f7ff",
        [200] = "#ebf5ff",
        [300] = "#e0f0ff",
        [400] = "#cce6ff",
        [500] = "#99ceff",
        [600] = "#52aeff",
        [700] = "#0072f5",
        [800] = "#0062d1",
        [900] = "#0068d6",
        [1000] = "#00254d",
      },
      amber = {
        [100] = "#fff6e6",
        [200] = "#fff4d6",
        [300] = "#fef0cd",
        [400] = "#ffdd8f",
        [500] = "#ffc96b",
        [600] = "#f5b047",
        [700] = "#ffb224",
        [800] = "#ff990a",
        [900] = "#a35200",
        [1000] = "#4e2009",
      },
      red = {
        [100] = "#fff0f0",
        [200] = "#ffebeb",
        [300] = "#ffe6e6",
        [400] = "#fdd8d8",
        [500] = "#f8b9b9",
        [600] = "#f87275",
        [700] = "#e5484d",
        [800] = "#da2f35",
        [900] = "#cb2a2f",
        [1000] = "#391417",
      },
      green = {
        [100] = "#effbef",
        [200] = "#ebfaeb",
        [300] = "#daf6da",
        [400] = "#c6f1c7",
        [500] = "#98e49d",
        [600] = "#6cda75",
        [700] = "#45a557",
        [800] = "#398e4a",
        [900] = "#297a3a",
        [1000] = "#1b311e",
      },
      teal = {
        [100] = "#eefcf9",
        [200] = "#e5faf6",
        [300] = "#d4f7f0",
        [400] = "#bef4eb",
        [500] = "#86ead9",
        [600] = "#45dec5",
        [700] = "#12a594",
        [800] = "#0d8c7d",
        [900] = "#067a6e",
        [1000] = "#073c34",
      },
      purple = {
        [100] = "#f9f0ff",
        [200] = "#f9f1fe",
        [300] = "#f4e8fc",
        [400] = "#eddcf9",
        [500] = "#d5b1f1",
        [600] = "#bf89ec",
        [700] = "#8e4ec6",
        [800] = "#763da9",
        [900] = "#7820bc",
        [1000] = "#2e004d",
      },
      pink = {
        [100] = "#ffebf5",
        [200] = "#feecf2",
        [300] = "#fce3ec",
        [400] = "#f9d7e2",
        [500] = "#f5b8cc",
        [600] = "#ee87a7",
        [700] = "#e83e82",
        [800] = "#df2670",
        [900] = "#bd2864",
        [1000] = "#430a23",
      },
      background = {
        [100] = "#ffffff",
        [200] = "#fafafa",
      },
    }
  else
    ---@type VercelPalette
    colors.palette = {
      gray = {
        [100] = "#1a1a1a",
        [200] = "#1f1f1f",
        [300] = "#292929",
        [400] = "#2e2e2e",
        [500] = "#454545",
        [600] = "#878787",
        [700] = "#8f8f8f",
        [800] = "#7d7d7d",
        [900] = "#a1a1a1",
        [1000] = "#ededed",
      },
      blue = {
        [100] = "#0f1c2e",
        [200] = "#10233d",
        [300] = "#0f2f57",
        [400] = "#0d3868",
        [500] = "#0a4380",
        [600] = "#0090ff",
        [700] = "#0072f5",
        [800] = "#0062d1",
        [900] = "#52a8ff",
        [1000] = "#ebf6ff",
      },
      amber = {
        [100] = "#291800",
        [200] = "#331b00",
        [300] = "#4d2a00",
        [400] = "#573300",
        [500] = "#6b4105",
        [600] = "#e79d13",
        [700] = "#ffb224",
        [800] = "#ff990a",
        [900] = "#f2a20d",
        [1000] = "#fef3dc",
      },
      red = {
        [100] = "#2a1314",
        [200] = "#3c1618",
        [300] = "#561a1e",
        [400] = "#671e21",
        [500] = "#832126",
        [600] = "#e5484d",
        [700] = "#e5484d",
        [800] = "#d93036",
        [900] = "#ff6166",
        [1000] = "#feecee",
      },
      green = {
        [100] = "#0b2212",
        [200] = "#0f2e18",
        [300] = "#12361b",
        [400] = "#0c451b",
        [500] = "#126426",
        [600] = "#1a9338",
        [700] = "#45a557",
        [800] = "#398e4a",
        [900] = "#62c073",
        [1000] = "#e5fbea",
      },
      teal = {
        [100] = "#04201b",
        [200] = "#062822",
        [300] = "#083a33",
        [400] = "#053d35",
        [500] = "#085e53",
        [600] = "#0c9784",
        [700] = "#12a594",
        [800] = "#0d8c7d",
        [900] = "#0ac7b4",
        [1000] = "#e0faf4",
      },
      purple = {
        [100] = "#231528",
        [200] = "#2e1938",
        [300] = "#422154",
        [400] = "#4f2768",
        [500] = "#5f2e85",
        [600] = "#8e4ec6",
        [700] = "#8e4ec6",
        [800] = "#763da9",
        [900] = "#bf7af0",
        [1000] = "#f8edfc",
      },
      pink = {
        [100] = "#28151d",
        [200] = "#3a1726",
        [300] = "#4f1c31",
        [400] = "#551b33",
        [500] = "#6c1e3e",
        [600] = "#b31957",
        [700] = "#ea3e83",
        [800] = "#df2670",
        [900] = "#f75f8f",
        [1000] = "#feecf4",
      },
      background = {
        [100] = "#0a0a0a",
        [200] = "#000000",
      },
    }
  end

  colors.blue = colors.palette.blue[900]
  colors.green = colors.palette.green[900]
  colors.purple = colors.palette.purple[900]
  colors.red = colors.palette.red[900]
  -- Aka. yellow
  colors.amber = colors.palette.amber[900]
  colors.pink = colors.palette.pink[900]
  -- Aka. cyan
  colors.teal = colors.palette.teal[900]

  colors.background = colors.palette.background[200]
  colors.background_comparison = colors.palette.background[100]
  colors.background_hover = colors.palette.gray[100]
  colors.background_active = colors.palette.gray[200]
  colors.background_match = colors.palette.amber[200]
  colors.background_diff_add = colors.palette.green[300]
  colors.background_diff_change = colors.palette.amber[300]
  colors.background_diff_delete = colors.palette.red[300]
  colors.background_info = colors.palette.blue[300]
  colors.background_success = colors.palette.green[300]
  colors.background_warning = colors.palette.amber[300]
  colors.background_error = colors.palette.red[300]
  colors.background_disable = colors.palette.gray[100]
  -- Aka. black for light theme, white for dark theme
  colors.background_reverse = colors.palette.gray[1000]

  colors.foreground = colors.palette.gray[1000]
  colors.secondary = colors.palette.gray[900]
  colors.tertiary = colors.palette.gray[800]
  colors.foreground_match = colors.palette.amber[900]
  colors.foreground_disable = colors.palette.gray[700]
  -- Aka. white for light theme, black for dark theme
  colors.foreground_reverse = colors.palette.background[100]

  colors.border = colors.palette.gray[200]
  colors.border_strong = colors.palette.gray[700]
  colors.border_info = colors.palette.blue[400]
  colors.border_success = colors.palette.green[400]
  colors.border_warning = colors.palette.amber[400]
  colors.border_error = colors.palette.red[400]
  colors.border_focus = colors.palette.blue[is_light and 700 or 900]

  colors.scrollbar_tracker = colors.palette.background[100]
  colors.scrollbar_thumb = colors.palette.gray[600]

  return colors
end

return M
