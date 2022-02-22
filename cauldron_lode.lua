-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local function temper(name, desc, sound, glow, dmg)

local form = "nc_lode_"..name..".png^[mask:nc_api_storebox_frame.png"

local side = "nc_lode_"..name..".png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_cauldron_" ..name, {
		description = desc.. " Lode Cauldron",
		tiles = {side, side, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			lode_cube = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			metallic = 1,
			lode_cauldron = 1,
			damage_touch = dmg
		},
		paramtype = "light",
		sunlight_propagates = true,
		sounds = nodecore.sounds(sound),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
	})

end

temper("annealed",	"Annealed",	"nc_lode_annealed",	false,	0)
temper("tempered",	"Tempered",	"nc_lode_tempered",	false,	0)
temper("hot",		"Glowing",	"nc_lode_annealed",	true,	0)

nodecore.register_craft({
		label = "heat lode cauldron",
		action = "cook",
		touchgroups = {flame = 3},
		duration = 30,
		cookfx = true,
		indexkeys = {"group:lode_cauldron"},
		nodes = {
			{
				match = {groups = {lode_cauldron = true}},
				replace = modname .. ":shelf_cauldron_hot"
			}
		}
	})

nodecore.register_craft({
		label = "assemble cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_lode:block_annealed"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_cauldron_annealed"
			},
		}
	})
	
nodecore.register_craft({
		label = "assemble tempered cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_lode:block_tempered"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_cauldron_tempered"
			},
		}
	})

