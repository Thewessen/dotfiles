-- Copied from https://github.com/ellisonleao/dotenv.nvim/
-- Only loading the .env file in the nvim directory
local uv = vim.loop
local dotenv = {}

dotenv.config = {
  verbose = false,
  path = vim.api.nvim_get_runtime_file(".env", false)[1]
}

local function notify(msg, level)
  if not dotenv.config.verbose then
    return
  end

  if level == nil then
    level = "INFO"
  end

  vim.notify(msg, vim.log.levels[level])
end

local function read_file(path)
  local fd = assert(uv.fs_open(path, "r", 438))
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end

local function parse_data(data)
  local values = vim.split(data, "\n")
  local out = {}
  for _, pair in pairs(values) do
    pair = vim.trim(pair)
    if not vim.startswith(pair, "#") and pair ~= "" then
      local splitted = vim.split(pair, "=")
      if #splitted > 1 then
        local key = splitted[1]
        local v = {}
        for i = 2, #splitted, 1 do
          local k = vim.trim(splitted[i])
          if k ~= "" then
            table.insert(v, splitted[i])
          end
        end
        if #v > 0 then
          local value = table.concat(v, "=")
          value, _ = string.gsub(value, '"', "")
          vim.env[key] = value
          out[key] = value
        end
      end
    end
  end
  return out
end

dotenv.setup = function(args)
  dotenv.config = vim.tbl_extend("force", dotenv.config, args or {})
  if dotenv.config.path == nil then
    notify("No .env file found", "WARN")
    return
  end
  local data = read_file(dotenv.config.path)
  local parsed = parse_data(data)

  notify("Loaded .env file", "INFO")
  return parsed
end

return dotenv
