-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local get_node = minetest.get_node
------------------------------------------------------------------------
local barrelwet = modname .. ":shelf_water_barrel"
local barreldry = modname .. ":shelf_wood_barrel"
-- ================================================================== --
local bark = "nc_tree_tree_top.png^[mask:nc_api_storebox_frame.png"
local wood = "nc_tree_tree_side.png^(" .. bark .. ")"
local knob = "nc_tree_tree_side.png^[mask:" ..modname.. "_knob_mask.png"
local lid = "nc_woodwork_plank.png^(" .. bark .. ")^(" .. knob .. ")"
local water = "(nc_terrain_water.png^[verticalframe:32:8)^[opacity:160"
local top = "(" ..water.. ")^(" ..bark.. ")"
-- ================================================================== --
local cpotdirs = {
	{x = 1, y = 0, z = 0},
	{x = -1, y = 0, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z = -1}
}
------------------------------------------------------------------------
local function findwater(pos)
	return nodecore.find_nodes_around(pos, "group:water")
end
------------------------------------------------------------------------
local function soakup(pos)
	local any
	for _, p in pairs(findwater(pos)) do
		nodecore.node_sound(p, "dig")
		minetest.remove_node(p)
		any = true
	end
	return any
end
-- ================================================================== --
minetest.register_node(modname .. ":shelf_wood_barrel", {
		description = "Wooden Barrel",
		tiles = {wood, wood, bark},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 10,
			storebox = 1,
			totable = 1,
			basketable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_wood_barrel" then
				return nodecore.stack_get(pos)
			end
		end
	})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble wooden barrel",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "nc_tree:log"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":shelf_wood_barrel"
			},
		}
	})
-- ================================================================== --
minetest.register_node(modname .. ":shelf_wood_barrel_lid", {
		description = "Closed Wooden Barrel",
		tiles = {wood, wood, lid},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 10,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 45
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_wood_barrel_lid" then
				return nodecore.stack_get(pos)
			end
		end
	})
-- ================================================================== --
minetest.register_node(modname .. ":shelf_water_barrel", {
		description = "Water Barrel",
		tiles = {wood, wood, top},
		use_texture_alpha = "blend",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 30,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 45,
			coolant = 1,
			moist = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_water_barrel" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "put lid on wooden barrel",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_wood_barrel"},
		wield = {name = "nc_woodwork:plank"}, --"nc_woodwork:toolhead_mallet" causes unsolved duplication bug
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_wood_barrel", empty = true},
				replace = modname .. ":shelf_wood_barrel_lid"
			},
		}
	})
-- ================================================================== --
minetest.register_abm({
		label = "fill water barrel",
		interval = 1,
		chance = 10,
		nodenames = {barreldry},
		neighbors = {"group:water"},
		action = function(pos)
			if soakup(pos) then
				nodecore.set_loud(pos, {name = barrelwet})
				return nodecore.fallcheck(pos)
			end
		end
	})

nodecore.register_aism({
		label = "stack fill water barrel",
		interval = 1,
		chance = 10,
		itemnames = {barreldry},
		action = function(stack, data)
			if data.pos and soakup(data.pos) then
				local taken = stack:take_item(1)
				taken:set_name(barrelwet)
				if data.inv then taken = data.inv:add_item("main", taken) end
				if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
				return stack
			end
		end
	})
-- ================================================================== --
nodecore.register_craft({
	label = "dump water barrel",
	action = "pummel",
	toolgroups = {thumpy = 1},
	indexkeys = {barrelwet},
	nodes = {
		{
			match = barrelwet,
			replace = barreldry
		}
	},
	after = function(pos)
		local found
		for _, d in pairs(cpotdirs) do
			local p = vector.add(pos, d)
			if nodecore.artificial_water(p, {
					matchpos = pos,
					match = barrelwet,
					minttl = 1,
					maxttl = 10
				}) then found = true end
		end
		if found then nodecore.node_sound(pos, "dig") end
	end
})
-- ================================================================== --
nodecore.register_craft({
		label = "remove lid from wooden barrel",
		action = "pummel",
		indexkeys = {modname.. ":shelf_wood_barrel_lid"},
		toolgroups = {choppy = 2},
		nodes = {
			{
				match = {name = modname.. ":shelf_wood_barrel_lid", empty = true},
				replace = modname .. ":shelf_wood_barrel"
			},
		},
		items = {
				{name = "nc_woodwork:toolhead_mallet", count = 1}
			}
	})
	
nodecore.register_ambiance({
		label = "water barrel ambiance",
		nodenames = {modname.. ":shelf_water_barrel"},
		neighbors = {"air"},
		interval = 20,
		chance = 20,
		sound_name = "nc_terrain_watery",
		sound_gain = 0.2
	})
