if not _G then
  if _ENV then
    _G = _ENV
  end
end
if not _ENV then
  if _G then
    _ENV =_G
  end
end
