-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = core.get_current_modname()

local function temper(name, desc, sound, glow, dmg)

local form = "nc_lode_"..name..".png^[mask:nc_api_storebox_frame.png"

local side = "nc_lode_"..name..".png^(" .. form .. ")"

core.register_node(modname .. ":shelf_lode_" ..name, {
		description = desc.. " Lode Shelf",
		tiles = {form, side, side},
		selection_box = nc.fixedbox(),
		collision_box = nc.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			lode_cube = 1,
			storebox = 1,
			totable = 1,
			scaling_time = 40,
			metallic = 1,
			storagelode =1,
			damage_touch = dmg
		},
		paramtype = "light",
		sunlight_propagates = true,
		sounds = nc.sounds(sound),
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
	})

end

temper("annealed",	"Annealed",	"nc_lode_annealed",	false,	0)
temper("tempered",	"Tempered",	"nc_lode_tempered",	false,	0)
temper("hot",		"Glowing",	"nc_lode_annealed",	true,	0)

nc.register_craft({
		label = "assemble lode shelf",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_lode:rod_annealed"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_lode_annealed"
			},
		}
	})

nc.register_craft({
		label = "heat lode shelf",
		action = "cook",
		touchgroups = {flame = 3},
		duration = 30,
		cookfx = true,
		indexkeys = {"group:storagelode"},
		nodes = {
			{
				match = {groups = {storagelode = true}},
				replace = modname .. ":shelf_lode_hot"
			}
		}
	})

nc.register_craft({
        label = "hot shelf annealing",
        action = "cook",
        touchgroups = {flame = 0},
        neargroups = {coolant = 0},
        duration = 30,
        priority = -1,
        cookfx = {smoke = true, hiss = true},
        nodes = {
            {
                match = {name = modname .. ":shelf_lode_hot"},
                replace = modname .. ":shelf_lode_annealed"
            }
        }
    })

nc.register_craft({
        label = "hot shelf quenching",
        action = "cook",
        touchgroups = {flame = 0},
        neargroups = {coolant = 1},
        cookfx = true,
        nodes = {
            {
                match = {name = modname .. ":shelf_lode_hot"},
                replace = modname .. ":shelf_lode_tempered"
            }
        }
    })


nc.register_craft({
		label = "recycle lode shelf",
		action = "pummel",
		indexkeys = {modname .. ":shelf_lode_annealed"},
		nodes = {
			{match = modname .. ":shelf_lode_annealed",
			replace = modname .. ":shelf_toolrack_annealed"},
			{y = -1, match = "nc_lode:block_tempered"}
		},
		
		toolgroups = {choppy = 5}
	})

nc.register_craft({
		label = "recycle lode shelf",
		action = "pummel",
		indexkeys = {modname .. ":shelf_lode_hot"},
		nodes = {
			{match = modname .. ":shelf_lode_hot",
			replace = modname .. ":shelf_toolrack_annealed"},
			{y = -1, match = "nc_lode:block_tempered"}
			},
		items = {{name = "nc_lode:prill_hot", count = 1, scatter = 2}},
		
		toolgroups = {choppy = 5}
	})
