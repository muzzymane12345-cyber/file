getgenv().whateverlolREAPINGDAHOODIANSTOOGT2 = {  

    ["Core"] = { 
        ["predictionresult"] = false, -- Keep it False for DaHood !!
        ["DebugMode"] = false,
        ["Bind Link"] = true, 
        ["DynamicMode"] = true,
        ["Hit-Scan Correction"] = false, -- NOT STABLE !! ))
        ["Load Check"] = true,
    },

    ["Binds"] = {
        ["LockOn"] = "C",
        ["Unlock"] = "Z",
        ["Aim Correction Toggle"] = "B",
        ["Assisted Clicking"] = "V",
        ["HideVisuals"] = "L",
        ["AxisInfluence Toggle"] = "H",
        ["Inventory Sorter"] = "I",
        ["RaidAwarenessAlly"] = "G",
        ["RaidAwarenessEnemy"] = "T",
        ["Macro"] = "X",
    },

    ["Enhanced Accuracy"] = {
        ["Enabled"] = true,
        ["Mode"] = "Target", -- Target // Auto --))
        ["BulletPoint"] = "ClosestPoint", 
        ["HitPower"] = 0.5, -- Higher the More Legit
        ["FOVType"] = 'BoxFOV', -- BoxFOV // CircleFOV
        ["Visible Target"] = true,

        ["Prediction"] = {
            ["Ground"] = 0,
            ["Air"] = 0,
        },
    },

     ["AxisInfluence"] = {
                 ["Enabled"] = true,
                 ["StartOn"] = 'Natural',

                 ["Debug Mode"] = {
                         ["Enabled"] = true,
                         ["Mode"] = 'Sound', -- Sound // Print ))
                },

                 ["AxisFix"] = {
                            ["Natural"] = 0.9,
                            ["Corrected"] = 0.5,
                            ["Assisted"] = 0.1,

                },                                

    },

    ["Aim Correction"] = {
        ["Enabled"] = true,
        ["Radius"] = 200,
        ["SafetyChecks"] = true,
        ["FirstPerson"] = true,
        ["ThirdPerson"] = false,
        ["StickyWithSilent"] = true, -- Auto True if you have Target Mode.))
        ["AimParts"] = "ClosestPart", -- ClosestPoint // ClosestPart ))

        ["Smoothness"] = {
            ['Ground'] = 0.006,
            ['Air'] = 0.006,
        },

        ["Easing"] = {
            ["Style"] = "Linear", -- "https://create.roblox.com/docs/reference/engine/enums/EasingStyle"
        },

        ["Prediction"] = {
            ["Ground"] = 0,
            ["Air"] = 0,
        },

    },

    ["Assisted Clicking"] = {
        ["Enabled"] = true,
        ["FOVType"] = "BoxFOV", -- BoxFOV // Hitbox
        ["Type"] = "Hold", -- Hold // Toggle
        ["Mode"] = "Keybind", -- Mouse // Keybind

        ["DelayTime"] = {
                    ["Enabled"] = false, -- KEEP FALSE FOR DA HOOD !!
                    ["[Double-Barrel SG]"] = 0.1,
                    ["[Revolver]"] = 0.1,
        },

         ["Switch Tool Delay"] = {
                              ["Enabled"] = false,
                              ["Switch Tools Delay"] = 0.5,

                              ["Activation Tools"] = {
                                                 "[Revolver]",
                                                 "[Double-Barrel SG]",
                                                 "[Drum-Shotgun]",
                                                 "[Shotgun]",
                                                 "[TacticalShotgun]",
                               },
        },
    
    },
    

    ["Bullet Spread Accuracy"] = {
        ["Enabled"] = false,

        ["Configuration"] = {
            ["RandomBulletsAccuracy"] = false,
            ["Accuracy"] = math.random(0.8, 1),
        },

        ["[Double-Barrel SG]"] = 1,
        ["[Drum-Shotgun]"] = 0.6,
        ["[Shotgun]"] = 1,
        ["[TacticalShotgun]"] = 1,
    },

    ["Visuals"] = {
             ["Raid Awareness"] = {
                            ["Visible"] = false,
                            ["Friend Check"] = false,

                            ["DistanceTarget"] = {
                                           ["Enabled"] = false,
                                           ["Distance"] = 400,
                            },

                            ["AllyBox"] = Color3.fromRGB(0, 255, 0),
                            ["EnemyBox"] = Color3.fromRGB(255, 0, 0),
                            ["Thickness"] = 1,
                            ["Transparency "] = 1,

                            ["OverLayNames"] = {
                                          ["Visible"] = true,
                                          ["Size"] = 14,
                                          ["Color"] = Color3.fromRGB(255, 255, 255),
                                          ["Transparency "] = 1,
                                          ["Outline "] = true,
                                          ["Offset "] = 2,
                            },

               },
            
    },

    ["FOV"] = {
        ["Enhanced Accuracy"] = {
            ["BoxFOV"] = {
                ["Visible"] = true,
                ["Thickness"] = 1,
                ["BoxColor"] = function() 
                    local hue = tick() % 5 / 5
                    return Color3.fromHSV(hue, 1, 1)
                end,
                
                ["Normal BoxFOV"] = {
                          ["LeftWidth"] = 1.7,
                          ["RightWidth"] = 1.7,
                          ["TopHeight"] = 2.5,
                          ["BottomHeight"] = 2.5,
                },

                ["Tools BoxFOV"] = {
                    ["Enabled"] = false,

                    ["[Double-Barrel SG]"] = {
                        ["LeftWidth"] = 1.7,
                        ["RightWidth"] = 1.7,
                        ["TopHeight"] = 2.5,
                        ["BottomHeight"] = 2.5,
                    },
                    ["[Revolver]"] = {
                        ["LeftWidth"] = 1.7,
                        ["RightWidth"] = 1.7,
                        ["TopHeight"] = 2.5,
                        ["BottomHeight"] = 2.5,
                    },
                    ["[TacticalShotgun]"] = {
                        ["LeftWidth"] = 1.7,
                        ["RightWidth"] = 1.7,
                        ["TopHeight"] = 2.5,
                        ["BottomHeight"] = 2.5,
                    },
                    ["Other Tools"] = {
                        ["LeftWidth"] = 1.7,
                        ["RightWidth"] = 1.7,
                        ["TopHeight"] = 2.5,
                        ["BottomHeight"] = 2.5,
                    },
                },
            },

            ["CircleFOV"] = {
                      ["Visible"] = true,
                      ["Thickness"] = 1,
                      ["CircleColor"] = Color3.fromRGB(128, 0, 128),

                      ["CircleRadius"] = {
                                 ["[Revolver]"] = {Close = 20, Mid = 30, Far = 50},
                                 ["[Double-Barrel SG]"] = {Close = 50, Mid = 65, Far = 80},
                                 ["[Drum-Shotgun]"] = {Close = 40, Mid = 50, Far = 60},
                                 ["[Shotgun]"] = {Close = 40, Mid = 50, Far = 60},
                                 ["[TacticalShotgun]"] = {Close = 40, Mid = 50, Far = 60},
                                 -- [[  ADD More Guns Below 
                                 -- ["[Blah Blah Gun]"] = {Close = 25, Mid = 40, Far = 70},
                                 --]] 
                       },
            },
    
                    
        },

        ["Assisted Clicking"] = {
            ["BoxFOV"] = {
                   ["Visible"] = true,
                   ["Thickness"] = 1,
                   ["BoxColor"] = function() 
                    local hue = tick() % 5 / 5
                    return Color3.fromHSV(hue, 1, 1)
                end,

                   ["Tools BoxFOV"] = {
                           ["Pistols BoxFOV"] = {
                                ["LeftWidth"] = 0.7,
                                ["RightWidth"] = 0.7,
                                ["TopHeight"] = 1.7,
                                ["BottomHeight"] = 2,
                           },

                           ["ShotGuns BoxFOV"] = {
                                ["LeftWidth"] = 0.7,
                                ["RightWidth"] = 0.7,
                                ["TopHeight"] = 1.7,
                                ["BottomHeight"] = 2,
                           },

                           ["Other Tools BoxFOV"] = {
                                ["LeftWidth"] = 0.7,
                                ["RightWidth"] = 0.7,
                                ["TopHeight"] = 1.7,
                                ["BottomHeight"] = 2,
                           },
                   },
            },
        },
    },

    ["Skin Changer"] = { 
                  ["Enabled"] = false,
                  ["Tools"] = {
                    ["[Revolver]"] = "Golden Age", -- Galaxy, Luck, Matrix, Golden Age, Christmas Wrap, Inferno, Iced Out
                    ["[Double-Barrel SG]"] = "Golden Age", -- Luck, Galaxy, Matrix, Golden Age, Christmas Wrap, Valentine
                    ["[TacticalShotgun]"] = "Luck", -- Luck, Galaxy, Matrix, Inferno, Christmas Wrap, Valentine
                    ["[Knife]"] = "Love Kukri", -- Love Kukri only tested skin, Most are probably buggy / not working
                    -- [[  ADD More Guns Below  ]]
                  },
    },

    ["Movement Enhancements"] = { 
             ['Speed Enhancements'] = {
                          ["Enabled"] = true,

                          ["Related Shooting"] = {
                                        ["While Shooting"] = 1.2,
                           },

                          ["Related Reloading"] = {
                                        ["While Reloading"] = 1.2,
                           },
                          ["Related Health"] = {         
                                        ["Low Health"] = 1.2,
                           },
               },
     },

    ["Inventory Sorter"] = {
        ["Enabled"] = false,
        ["Hide Junk"] = true,

        ["Slots"] = {
            ['1'] = "[Revolver]",
            ['2'] = "[Double-Barrel SG]",
            ['3'] = "[TacticalShotgun]",
            ['4'] = "[Shotgun]",
            ['5'] = "[Knife]"
        },
    },

       ['Macro'] = {
           ["Enabled"] = false,
           ["Type"] = "ThirdPerson", -- ThirdPerson // FirstPerson.
           ["Delay"] = 0.01,
           ["HoldMode"] = true,
    },

    ["AutoPrediction"] = {
             ["Enabled"] = false,
             ["UpdateOnPingSpike"] = true, -- Only update when ping changes significantly
             ["MinimumPingChange"] = 10, -- Only update if ping changes by 10+ ms

             ["PingRanges"] = {
                         ["10-20"] = 0.115,
                         ["20-30"] = 0.120,
                         ["30-40"] = 0.125,
                         ["40-50"] = 0.130,
                         ["50-60"] = 0.135,
                         ["60-70"] = 0.140,
                         ["70-80"] = 0.145,
                         ["80-90"] = 0.150,
                         ["90-100"] = 0.155,
                         ["100-110"] = 0.160,
                         ["110-120"] = 0.165,
                         ["120-130"] = 0.170,
                         ["130+"] = 0.175, 
    },
},

} 
