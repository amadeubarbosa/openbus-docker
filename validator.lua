local function validator(name, password)
  if name == password then
    return true
  end
end

return function(configs) return validator end
