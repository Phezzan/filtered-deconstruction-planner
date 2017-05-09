-- Give LuaEntity and get the corresponding entity-name for the filter
-- Different tree entities get pooled under "fdp-tree-proxy"
function get_entity_name(entity)
  if not entity then
    return nil
  elseif string.sub(entity.name, string.len(entity.name) - 3, -1) == "rail" then
    return "rail"
  elseif entity.name == "item-on-ground" then
    return entity.stack.name
  elseif entity.name == "deconstructible-tile-proxy" then
    return entity.surface.get_tile(entity.position.x, entity.position.y).prototype.mineable_properties.products[1].name
  elseif entity.type == "tree" then
    if string.sub(entity.name, 1, 4) == "dead" then
      return "fdp-dead-proxy"
    elseif string.sub(entity.name, 1, 3) == "dry" then
      return "fdp-dead-proxy"
    else 
      return "fdp-tree-proxy"
    end
  else
    return entity.name
  end
end

-- Return the sprite identifier for a given filter
function get_sprite_for_filter(filter)
  if filter == "" then
    return ""
  elseif filter == "fdp-dead-proxy" then
    return "entity/dead-grey-trunk"
  elseif filter == "fdp-tree-proxy" then
    return "entity/tree-03"
  elseif filter == "stone-rock" then
    return "entity/stone-rock"
  else
    return "item/"..filter
  end
end

-- Check if the given entity-name is in the current filter configuration
function is_in_filter(player, entity_name)
  for i = 1, #global["config"][player.index]["filter"] do
    if global["config"][player.index]["filter"][i] == entity_name then
      return true
    end
  end

  return false
end
