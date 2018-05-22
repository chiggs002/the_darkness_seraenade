{
	"patcher" : 	{
		"rect" : [ 665.0, 44.0, 598.0, 384.0 ],
		"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
		"bglocked" : 0,
		"defrect" : [ 665.0, 44.0, 598.0, 384.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 10.0,
		"default_fontface" : 0,
		"default_fontname" : "Lato",
		"toolbarvisible" : 1,
		"boxfadetime" : 200,
		"boxanimatetime" : 200,
		"scrollanimatetime" : 200,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "send base pitch value to all operators in this patch",
					"linecount" : 2,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 0.0, 151.0, 138.0, 33.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-45",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "bogue receive~: to avoid error messages when loading",
					"linecount" : 4,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 265.0, 288.0, 119.0, 60.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-44",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "<- voice is always on.",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 450.0, 293.0, 119.0, 20.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-43",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "1, mute 0",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 393.0, 294.0, 59.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-42",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "FM audio out",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 114.0, 348.0, 78.0, 20.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-41",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"outlettype" : [  ],
					"ignoreclick" : 0,
					"patching_rect" : [ 129.0, 327.0, 25.0, 25.0 ],
					"hidden" : 0,
					"boxalpha" : 1.0,
					"presentation" : 0,
					"id" : "obj-40",
					"numinlets" : 1,
					"comment" : "FM audio out"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "set envelope shapes",
					"linecount" : 2,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 515.0, 83.0, 74.0, 33.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-38",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "set harmonicity values",
					"linecount" : 2,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 420.0, 83.0, 90.0, 33.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-37",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "This configuration yields 2 parallel modulation pairs",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 12.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 193.0, 56.0, 305.0, 22.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Geneva CY",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-36",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "pitch in",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 1,
					"patching_rect" : [ 119.0, 18.0, 45.0, 20.0 ],
					"underline" : 0,
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-35",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 129.0, 34.0, 25.0, 25.0 ],
					"hidden" : 0,
					"boxalpha" : 1.0,
					"presentation" : 0,
					"id" : "obj-34",
					"numinlets" : 0,
					"comment" : "pitch in"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"triangle" : 1,
					"background" : 0,
					"mouseup" : 0,
					"triscale" : 1.0,
					"numoutlets" : 2,
					"format" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "int", "bang" ],
					"ignoreclick" : 0,
					"maximum" : "<none>",
					"cantchange" : 0,
					"patching_rect" : [ 129.0, 74.0, 50.0, 18.0 ],
					"transparent" : 0,
					"hidden" : 0,
					"minimum" : "<none>",
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-33",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1env3",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 418.0, 185.0, 56.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-30",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "carrier #1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "signal" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 316.0, 216.0, 121.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-31",
					"numinlets" : 4
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1harm3",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 350.0, 185.0, 63.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-32",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1env1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 231.0, 185.0, 56.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-27",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "carrier #1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "signal" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 129.0, 216.0, 121.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-28",
					"numinlets" : 4
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1harm1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 163.0, 185.0, 63.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-29",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1env4",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 508.0, 112.0, 56.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-24",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "modulator #1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "signal" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 406.0, 143.0, 121.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-25",
					"numinlets" : 4
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1harm4",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 440.0, 112.0, 63.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-26",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "set $1pitchbase",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 21.0, 71.0, 90.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-23",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thispoly~",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 2,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "int", "int" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 393.0, 319.0, 57.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-22",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "bang" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 393.0, 269.0, 58.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-21",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "receive~ bogue",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "signal" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 277.0, 269.0, 90.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-20",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "out~ 1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 0,
					"patching_rect" : [ 163.0, 327.0, 43.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-19",
					"numinlets" : 1,
					"save" : [ "#N", "out~", 1, ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "+~",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "signal" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 129.0, 275.0, 30.470589, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-18",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1env2",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 321.0, 112.0, 56.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-13",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "modulator #1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "signal" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 219.0, 143.0, 121.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-10",
					"numinlets" : 4
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r #1harm2",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 253.0, 112.0, 63.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-6",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "in 1",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 159.0, 34.0, 29.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-5",
					"numinlets" : 1,
					"save" : [ "#N", "in", 1, ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sig~",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "signal" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 79.0, 101.0, 32.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-4",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "send~ bogue",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [  ],
					"ignoreclick" : 0,
					"patching_rect" : [ 21.0, 134.0, 78.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-3",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thispoly~",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 2,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "int", "int" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 21.0, 42.0, 57.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-2",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"linecount" : 1,
					"background" : 0,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 0.0, 0.0 ],
					"fontsize" : 10.0,
					"outlettype" : [ "bang" ],
					"ignoreclick" : 0,
					"patching_rect" : [ 21.0, 16.0, 58.0, 20.0 ],
					"hidden" : 0,
					"fontname" : "Lato",
					"boxalpha" : 1.0,
					"presentation" : 0,
					"fontface" : 0,
					"id" : "obj-1",
					"numinlets" : 1
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-23", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-23", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-10", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-26", 0 ],
					"destination" : [ "obj-25", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-25", 3 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-10", 3 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-28", 3 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-29", 0 ],
					"destination" : [ "obj-28", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [ 88.5, 126.0, 30.5, 126.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-31", 3 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-32", 0 ],
					"destination" : [ "obj-31", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-34", 0 ],
					"destination" : [ "obj-33", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-33", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"color" : [ 0.239216, 0.643137, 0.709804, 1.0 ],
					"midpoints" : [ 138.5, 96.0, 88.5, 96.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"color" : [ 0.239216, 0.643137, 0.709804, 1.0 ],
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"color" : [ 0.239216, 0.643137, 0.709804, 1.0 ],
					"midpoints" : [ 138.5, 111.0, 228.5, 111.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"color" : [ 0.239216, 0.643137, 0.709804, 1.0 ],
					"midpoints" : [ 138.5, 107.0, 415.5, 107.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 0,
					"color" : [ 0.239216, 0.643137, 0.709804, 1.0 ],
					"midpoints" : [ 138.5, 175.0, 325.5, 175.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-40", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-42", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-42", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-31", 0 ],
					"destination" : [ "obj-18", 1 ],
					"hidden" : 0,
					"midpoints" : [ 325.5, 253.0, 149.970581, 253.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-28", 2 ],
					"hidden" : 0,
					"midpoints" : [ 228.5, 211.0, 206.5, 211.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-31", 2 ],
					"hidden" : 0,
					"midpoints" : [ 415.5, 211.0, 393.5, 211.0 ]
				}

			}
 ]
	}

}
