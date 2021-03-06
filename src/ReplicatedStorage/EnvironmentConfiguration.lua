--[[
TheNexusAvenger

Environment-specific variables depending on
where it is uploaded.

The animations only work in Nexus Development's place because animations only work for the owner.
If animations become free, this will solve this problem.
https://devforum.roblox.com/t/public-animations/43299
--]]

if game.PlaceId == 5674151342 then
    --Nexus Development Quality Assurance test
    return {
        --Custom animations used in the game.
        Animations = {
            SwordAttack = "rbxassetid://2960989171",
            SwordLunge = "rbxassetid://2960989618",
            SwordOverhead = "rbxassetid://2960990006",
        },

        --Developer Produced used in the game.
        DeveloperProducts = {
            HalloCycle = 1087548927,
            TrickOrTreatBag = 1087549221,
            Candy17 = 1087549438,
            Candy85 = 1087549718,
            Candy170 = 1087549770,
            Candy850 = 1087549867,
            Candy1700 = 1087549950,
            Candy8500 = 1087550004,
            Candy17000 = 1087550065,
            Candy85000 = 1087550098,
        },

        --Badges used in the game.
        Badges = {
            BloxkinCollector = 2124612003,
            ThePortal = 2124612004,
            BloxhildasRevenge = 2124612005,
            BeyondTheRocks = 2124612006,
        },
    }
else
    --Nexus Development release (default)
    return {
        --Custom animations used in the game.
        Animations = {
            SwordAttack = "rbxassetid://2117143663",
            SwordLunge = "rbxassetid://2117144519",
            SwordOverhead = "rbxassetid://2117142586",
        },

        --Developer Produced used in the game.
        DeveloperProducts = {
            HalloCycle = 1087853295,
            TrickOrTreatBag = 1087853338,
            Candy17 = 1087852933,
            Candy85 = 1087853001,
            Candy170 = 1087853032,
            Candy850 = 1087853060,
            Candy1700 = 1087853141,
            Candy8500 = 1087853169,
            Candy17000 = 1087853198,
            Candy85000 = 1087853232,
        },

        --Badges used in the game.
        Badges = {
            BloxkinCollector = 2124610820,
            ThePortal = 2124610829,
            BloxhildasRevenge = 2124610830,
            BeyondTheRocks = 2124610831,
        },
    }
end