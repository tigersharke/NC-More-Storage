-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"
local side = "nc_lode_annealed.png^(" .. form .. ")"
local acid = "wc_meltdown_corrosive.png^(" ..form.. ")"
------------------------------------------------------------------------
local function findacid(pos)
	return nodecore.find_nodes_around(pos, "group:caustic_fluid")
end
------------------------------------------------------------------------
local function soakup(pos)
	local any
	for _, p in pairs(findacid(pos)) do
		nodecore.node_sound(p, "dig")
		minetest.remove_node(p)
		any = true
	end
	return any
end
-- ================================================================== --
minetest.register_node(modname .. ":battery", {
		description = "Corrosive Battery",
		tiles = {acid, side, side},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 4,
			totable = 1,
			scaling_time = 50,
			corrosive = 1,
			falling_node = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_lode_annealed"),
	})
-- ================================================================== --
minetest.register_abm({
		label = "fill cauldron with acid",
		interval = 1,
		chance = 10,
		nodenames = {modname .. ":shelf_cauldron_annealed"},
		neighbors = {"group:caustic_fluid"},
		action = function(pos)
			if soakup(pos) then
				nodecore.set_loud(pos, {name = modname .. ":battery"})
				return nodecore.fallcheck(pos)
			end
		end
	})

nodecore.register_aism({
		label = "stack fill acid cauldron",
		interval = 1,
		chance = 10,
		itemnames = {modname .. ":shelf_cauldron_annealed"},
		action = function(stack, data)
			if data.pos and soakup(data.pos) then
				local taken = stack:take_item(1)
				taken:set_name(modname .. ":battery")
				if data.inv then taken = data.inv:add_item("main", taken) end
				if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
				return stack
			end
		end
	})
-- ================================================================== --
nodecore.register_ambiance({
		label = "battery ambiance",
		nodenames = {modname.. ":battery"},
		neighbors = {"air"},
		interval = 20,
		chance = 20,
		sound_name = "nc_terrain_bubbly",
		sound_gain = 0.2
	})