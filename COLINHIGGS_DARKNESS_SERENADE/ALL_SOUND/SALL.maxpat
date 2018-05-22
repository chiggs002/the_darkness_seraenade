{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 7,
			"minor" : 3,
			"revision" : 4,
			"architecture" : "x86",
			"modernui" : 1
		}
,
		"rect" : [ 197.0, 193.0, 797.0, 650.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"boxes" : [ 			{
				"box" : 				{
					"fontface" : 1,
					"id" : "obj-17",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 283.833313, 21.0, 235.0, 20.0 ],
					"style" : "",
					"text" : "The Darkness Serenade  by Colin Higgs"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"linecount" : 26,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 485.0, 88.0, 288.0, 355.0 ],
					"style" : "",
					"text" : "The following sounds and samples can be called:\n\nS01_STARTA    –   A 16 voice poly patch that uses noise with a Reson filter to output random noise values\n\nS00_FOURIER  –  Uses Noise in fourier transform to output discreet packets of noise that slowly dissipate\n\nS02_ACCEL      –  Another filter comb~ uses a  sample input to mix to timings of the sample\n\nS03_SAMLPLES- Uses 9 samples in the patch and mixes them together with different timings\n\nS04_ACCEL      –  Uses a fffb~ filter  a subtractive filter uses pink noise to give discreet packets of noise similar to \n\nS05_ACCEL –  Based on the fm-surfer patch. A frequency modular syntheziser \n\nS06_SAMPLES_RESTART – Uses 9 another set of samples in the patch and mixes them together with different timings."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"id" : "obj-10",
					"linecount" : 27,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 10.0, 95.0, 338.0, 368.0 ],
					"style" : "",
					"text" : "This is the main group collective patch for the installation.\n\nColin Higgs The Darkness Seranade\n\nS_CONDUCTOR1:  controls all other patches.\n                                Gets instructions from OSC\n\nSent from processing. PORT: 6022  /wek/outputs\n\nSENDS A MESSAGE TO PLAY THE FOLLOWING LISTED  PATCHES FOR \"X\" MILLISECS:\n\nS00_FOURIER\nS01_STARTA\nS02_ACCEL\nS03_SAMLPLES\nS04_ACCEL\nS05_ACCEL\nS06_SAMPLES_RESTART\n\n\n\n\n\n\n\n"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 326.0, 351.0, 157.0, 22.0 ],
					"style" : "",
					"text" : "S06_SAMPLES_RESTART"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 350.0, 289.0, 79.0, 22.0 ],
					"style" : "",
					"text" : "S05_ACCEL"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 345.5, 244.0, 79.0, 22.0 ],
					"style" : "",
					"text" : "S04_ACCEL"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 345.5, 202.0, 102.0, 22.0 ],
					"style" : "",
					"text" : "S03_SAMLPLES"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 350.0, 161.0, 87.0, 22.0 ],
					"style" : "",
					"text" : "S02B_ACCEL"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 350.0, 124.0, 84.0, 22.0 ],
					"style" : "",
					"text" : "S01_STARTA"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 350.0, 89.0, 93.0, 22.0 ],
					"style" : "",
					"text" : "S00_FOURIER"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 113.0, 52.0, 110.0, 22.0 ],
					"style" : "",
					"text" : "S_CONDUCTOR1"
				}

			}
 ],
		"lines" : [  ],
		"parameters" : 		{
			"obj-3::obj-8" : [ "live.gain~[2]", "live.gain~", 0 ],
			"obj-3::obj-13::obj-21::obj-6" : [ "live.tab[3]", "live.tab[1]", 0 ],
			"obj-4::obj-11" : [ "flonum", "flonum", 0 ],
			"obj-3::obj-13::obj-35" : [ "[5]", "Level", 0 ],
			"obj-3::obj-9" : [ "live.gain~", "live.gain~", 0 ],
			"obj-3::obj-82" : [ "live.gain~[1]", "live.gain~", 0 ]
		}
,
		"dependency_cache" : [ 			{
				"name" : "S_CONDUCTOR1.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "S00_FOURIER.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "fp_fft_chplay01.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "demosound.maxpat",
				"bootpath" : "C74:/help/msp",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "sine.svg",
				"bootpath" : "C74:/media/max/picts/m4l-picts",
				"type" : "svg ",
				"implicit" : 1
			}
, 			{
				"name" : "saw.svg",
				"bootpath" : "C74:/media/max/picts/m4l-picts",
				"type" : "svg ",
				"implicit" : 1
			}
, 			{
				"name" : "square.svg",
				"bootpath" : "C74:/media/max/picts/m4l-picts",
				"type" : "svg ",
				"implicit" : 1
			}
, 			{
				"name" : "random.svg",
				"bootpath" : "C74:/media/max/picts/m4l-picts",
				"type" : "svg ",
				"implicit" : 1
			}
, 			{
				"name" : "08 Mesa.mp3",
				"bootpath" : "~/Library/Mobile Documents/com~apple~CloudDocs/MAXMSP CLASS/MAXPMSP_PROJECT/usefulpatches/fuorier tranform",
				"patcherrelativepath" : "../../../Library/Mobile Documents/com~apple~CloudDocs/MAXMSP CLASS/MAXPMSP_PROJECT/usefulpatches/fuorier tranform",
				"type" : "Mp3 ",
				"implicit" : 1
			}
, 			{
				"name" : "16 Where We're Going.mp3",
				"bootpath" : "~/Library/Mobile Documents/com~apple~CloudDocs/MAXMSP CLASS/MAXPMSP_PROJECT/usefulpatches/fuorier tranform",
				"patcherrelativepath" : "../../../Library/Mobile Documents/com~apple~CloudDocs/MAXMSP CLASS/MAXPMSP_PROJECT/usefulpatches/fuorier tranform",
				"type" : "Mp3 ",
				"implicit" : 1
			}
, 			{
				"name" : "S01_STARTA.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "noisefilter.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "S02B_ACCEL.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "S03_SAMLPLES.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "helpdetails.js",
				"bootpath" : "C74:/help/resources",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "S04_ACCEL.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "S05_ACCEL.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "LFOwaveform.maxpat",
				"bootpath" : "/Users/Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"patcherrelativepath" : "../../../../Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "fm2143.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "modulator.maxpat",
				"bootpath" : "/Users/Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"patcherrelativepath" : "../../../../Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "carrier.maxpat",
				"bootpath" : "/Users/Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"patcherrelativepath" : "../../../../Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "jitter.maxpat",
				"bootpath" : "/Users/Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"patcherrelativepath" : "../../../../Shared/Max 7/Examples/legacy-examples/synths/fm-surfer-folder/lib",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "S06_SAMPLES_RESTART.maxpat",
				"bootpath" : "~/Desktop/COLINHIGGS_DARKNESS_SERENADE/ALL_SOUND",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
 ],
		"autosave" : 0,
		"styles" : [ 			{
				"name" : "dialGold",
				"default" : 				{
					"bgcolor" : [ 0.764706, 0.592157, 0.101961, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "ksliderWhite",
				"default" : 				{
					"color" : [ 1.0, 1.0, 1.0, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "newobjBlue-1",
				"default" : 				{
					"accentcolor" : [ 0.317647, 0.654902, 0.976471, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "newobjBrown-1",
				"default" : 				{
					"accentcolor" : [ 0.654902, 0.572549, 0.376471, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "newobjCyan-1",
				"default" : 				{
					"accentcolor" : [ 0.029546, 0.773327, 0.821113, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "newobjGreen-1",
				"default" : 				{
					"accentcolor" : [ 0.0, 0.533333, 0.168627, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "newobjYellow-1",
				"default" : 				{
					"accentcolor" : [ 0.82517, 0.78181, 0.059545, 1.0 ],
					"fontsize" : [ 12.059008 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "numberGold-1",
				"default" : 				{
					"accentcolor" : [ 0.764706, 0.592157, 0.101961, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
 ]
	}

}
