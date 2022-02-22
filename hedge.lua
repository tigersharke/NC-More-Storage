-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local hedge = "wc_naturae_shrub.png^(" .. form .. ")"

minetest.register_node(modname .. ":hedge", {
		description = "Box Hedge",
		drawtype = "allfaces_optional",
		tiles = {hedge},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			green = 1,
			leafy = 1,
			storebox = 1,
			flammable = 3,
			fire_fuel = 3,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":hedge" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "box hedge",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "wc_naturae:shrub_loose"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":hedge"
			},
		}
	})

local function fertile(pos, node_if_air)
	local below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local bnode = minetest.get_node(below)
	if minetest.get_item_group(bnode.name, "soil") < 1 then return end
	if #nodecore.find_nodes_around(pos, "group:moist", 2) < 1 then return end
	if not node_if_air then return true end
	local sdef = minetest.registered_nodes[node_if_air.name] or {}
	local maxlight = sdef[modname .. "_spread_max_light"]
	if maxlight then
		local ll = nodecore.get_node_light(pos) or 15
		if ll > maxlight then return end
	end
	local node = minetest.get_node(pos)
	local def = (node.name ~= "ignore") and minetest.registered_nodes[node.name] or {}
	return def.air_equivalent
end

minetest.register_abm({
		label = "box hedge spreading",
		nodenames = {modname.. ":hedge"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			if not fertile(pos) then return end
			local gro = {
				x = pos.x + math_random(-1, 1),
				y = pos.y + math_random(-1, 1),
				z = pos.z + math_random(-1, 1)
			}
			if not fertile(gro, node) then return end
			if #nodecore.find_nodes_around(pos, "wc_naturae:shrub", 4) >= 20 then return end
			return nodecore.set_loud(gro, {name = "wc_naturae:shrub"})
		end
	})
