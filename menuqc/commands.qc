
 void() confirm_profile;
 void() menuprofile_prev;
 void() menuprofile_next;
 void() load_tether;
 void() load_shrine;
 float checked_profiles;
 float oldprofileslot;

 void() menuprofile_select;
 void(float local_option, float isenter) check_keys = { if ((!mouseactive) && (isenter == 1))
 		return;

 	if (local_option > 0)
 		localsound("sounds/menu.wav");
 	if ((local_option >= 250) && (local_option <= 274))
 		menutype = M_TYPE_CONFIRMRESOLUTION;
 	//	if((selected_option >= 274) && (selected_option <= 276))
 	//	menutype = M_TYPE_CONFIRMRESOLUTION;

 	if ((local_option >= 307) && (local_option <= 311))
 		menutype = M_TYPE_CONFIRMANTIALIAS;

 	if (local_option == 322)
 		menutype = M_TYPE_CONFIRMFULLSCREEN;
 	if ((local_option >= 500) && (local_option <= 527))
 	{
 		keybind = 0;
 		mousereleased = 0;
 		menutype = M_TYPE_CONFIRMBIND;
 		gkcommand = local_option - 499;
 	}

 	switch (local_option)
 	{
 		case 1:
 			menutype = M_TYPE_PROFILE;
 			break;
 		case 2:
 			read_currentprofileslot();
 			//check_profileslot();
 			profileslotpage = profileslot;
 			check_profilenames();
			check_profilemenuversion();
			selected_option = 0;
			nprof = 0;
 			menutype = M_TYPE_RESUME;
 			break;
 		case 3:
 			cmd("\nquit\n");
 			//menutype = M_YNQ;
 			break;
 		case 4:
 			confirm_profile();
 			menutype = M_TYPE_SELECT_DIFFICULT;
 			break;
 		case 5:
			if(profileslot < 1)
			profileslot = 1;
			
			profilesammount = current_local_profilenames();
 			menuprofile_select();
 			number_load_selected = 0;
 			type_load_selected = 0;			
			write_profileslot();
			check_profilemenuversion();
 			//menuprofile_prev();
			 read_currentprofileslot();
 			//check_profileslot();
 			profileslotpage = profileslot;
 			check_profilenames();
			selected_option = 0;
			
			nprof = 0;
 			break;
 		case 6:
 			//menuprofile_next();
 			type_load_selected = number_load_selected;
 			break;
 			// In Game Menu
 		case 7:	// new game
 			menutype = M_TYPE_PLAYING;
 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			if (type_load_selected == 1)
 				load_autosave();
 			if (type_load_selected == 2)
 			{
 				write_tether2(1);
 				load_tether();
 			}

 			if (type_load_selected == 3)
 			{
 				write_shrine(1);
 				load_shrine();
 			}

 			type_load_selected = 0;
 			number_load_selected = 0;
 			break;
 		case 8:
 			menutype = M_TYPE_PLAYING;

 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			load_tether();
 			break;
 		case 9:
 			menutype = M_TYPE_PLAYING;

 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			load_shrine();
 			break;
 		case 10:
 			restart_consize();
 			checked_profiles = 0;
 			menutype = M_TYPE_OPTIONS;
 			break;
 		case 11:
 			menutype = M_TYPE_CONTROLS;
 			break;
 		case 12:
 			menutype = M_TYPE_VIDEO;
 			vid_aalias = cvar("vid_samples");
 			break;
 		case 13:
 			cmd("map newmap\n");
 			cmd("skill 2\n");
 			break;
 		case 14:
 			menutype = M_TYPE_AUDIO;
 			break;
 		case 15:
 			menutype = M_TYPE_GAMEPLAY;
 			break;
 		case 16:
			menutype = M_TYPE_DELETEPROFILE;
 			break;
 		case 17:		
			deleteprofile ();
			profileslot = 8;
			profileslotpage = 8;
			profilesammount = current_local_profilenames();
			if(profilesammount < 1)
			{
			profilesammount = 0;
			profileslot = 0;
			write_totalprofileslot();
			menutype = M_TYPE_NONE;
			}
			else
			{
 			read_currentprofileslot();
 			//check_profileslot();
 			check_profilenames();
			check_profilemenuversion();
			selected_option = 0;
			nprof = 0;
 			menutype = M_TYPE_RESUME;
			}
			selected_option = 0;
			break;			
 		case 18:
 			menutype = M_TYPE_RESOLUTION;
 			vid_fullscr = cvar("vid_fullscreen");
 			vid_wres = cvar("vid_width");
 			vid_hres = cvar("vid_height");
 			break;
 		case 34:
 			if (coronaoclussion == 1)
 				cmd("r_coronas_occlusionquery 0\n");
 			else
 				cmd("r_coronas_occlusionquery 1\n");
 			break;
 		case 35:
 			string vols, volsv;
 			float volv;
 			if (volm > 0)
 				volv = volm - 0.1;
 			else
 				volv = 0;
 			volsv = ftos(volv);
 			vols = strcat("volume ", volsv, " \n");
 			cmd(vols);
 			break;
 		case 36:
 			if (volm < 1)
 				volv = volm + 0.1;
 			else
 				volv = 1;
 			volsv = ftos(volv);
 			vols = strcat("volume ", volsv, " \n");
 			cmd(vols);
 			break;
 		case 99:
 			if (fscselected == 1)
 				cmd("vid_fullscreen 0\n");
 			else
 				cmd("vid_fullscreen 1\n");
 			break;
 		case 39:
 			if (versync == 1)
 				cmd("vid_vsync 0\n");
 			else
 				cmd("vid_vsync 1\n");
 			cmd("vid_restart \n");
 			break;
 		case 40:
 			if (antial == 8)
 				cmd("vid_samples 0\n");
 			else
 				cmd("vid_samples 8\n");
 			cmd("vid_restart \n");
 			break;
 		case 41:
 			menutype = M_TYPE_DNONE;
 			break;
 		case 42:
 			menutype = M_TYPE_NONE;
 			cmd("\n disconnect \n");
 			m_init2();
 			//menutype = M_YND;
 			break;
 		case 43:
 			if (isserver() || (clientstate() == CS_CONNECTED))	// don't back out to console only
 				m_hide();
 			break;

 			//////////// SELECT DIFFICULT		
 		case 45:
 			cmd("skill 0 \n");
 			cmd("map hub1\n");
 			break;
 		case 46:
 			cmd("skill 1 \n");
 			cmd("map hub1\n");
 			break;
 		case 47:
 			cmd("skill 2 \n");
 			cmd("map hub1\n");
 			break;
 		case 48:
 			cmd("skill 3 \n");
 			cmd("map hub1\n");
 			break;
 			//////////// CONTROLS BUTTONS		
 		case 101:
 			string sens, sensv;
 			float senv;
 			if (senm > 1)
 				senv = senm - 0.1;
 			else
 				senv = 1;
 			sensv = ftos(senv);
 			sens = strcat("sensitivity ", sensv, " \n");
 			cmd(sens);
 			break;
 		case 102:
 			if (senm < 10)
 				senv = senm + 0.1;
 			else
 				senv = 10;
 			sensv = ftos(senv);
 			sens = strcat("sensitivity ", sensv, " \n");
 			cmd(sens);
 			break;

 		case 103:
 			string acels, acelsv;
 			float acelv;
 			if (acel > 0)
 				acelv = acel - 0.1;
 			else
 				acelv = 0;
 			acelsv = ftos(acelv);
 			acels = strcat("m_accelerate ", acelsv, " \n");
 			cmd(acels);
 			break;
 		case 104:
 			if (acel < 10)
 				acelv = acel + 0.1;
 			else
 				acelv = 10;
 			acelsv = ftos(acelv);
 			acels = strcat("m_accelerate ", acelsv, " \n");
 			cmd(acels);
 			break;
 		case 105:
 			float checked;
 			checked = cvar("m_filter");
 			if (checked == 1)
 				cmd("m_filter 0\n");
 			else
 				cmd("m_filter 1\n");
 			break;
 		case 106:
 			float checked2;
 			checked2 = cvar("m_pitch");
 			if (checked2 <= -0.022)
 				cmd("m_pitch 0.022\n");
 			else
 				cmd("m_pitch -0.022\n");
 			break;
 		case 107:
 			float checked3;
 			checked3 = cvar("cl_rollangle");
 			if (checked3 == 2)
 				cmd("cl_rollangle 0\n");
 			else
 				cmd("cl_rollangle 2\n");
 			break;
 		case 108:
 			float checked4;
 			checked4 = cvar("cl_bob");
 			if (checked4 == 0.005)
 				cmd("cl_bob 0\n");
 			else
 				cmd("cl_bob 0.005\n");
 			break;
 		case 109:
 			float checked5;
 			checked5 = cvar("saved1");
 			if (checked5 == 1)
 				cmd("saved1 0\n");
 			else
 				cmd("saved1 1\n");
 			break;
 		case 110:
 			float checked6;
 			checked6 = cvar("saved3");
 			cmd("impulse 82\n");
 			if (checked6 == 1)
 				cmd("saved3 0\n");
 			else
 				cmd("saved3 1\n");
 			break;

 		case 111:
 			float checked7;
 			checked7 = cvar("saved4");
 			if (checked7 == 1)
 				cmd("saved4 0\n");
 			else
 				cmd("saved4 1\n");
 			break;
 		case 112:
 			float checked_decal;
 			checked_decal = cvar("cl_decals");
 			if (checked_decal == 1)
 				cmd("cl_decals 0\n");
 			else
 				cmd("cl_decals 1\n");
 			break;
 			//////////// VOLUME BUTTONS
 		case 201:
 			string mvolumes, mvolumesv;
 			float mvolumev;
 			if (mvol >= 0.05)
 				mvolumev = mvol - 0.05;
 			else
 				mvolumev = 0;
 			mvolumesv = ftos(mvolumev);
 			mvolumes = strcat("mastervolume ", mvolumesv, " \n");
 			cmd(mvolumes);
 			break;
 		case 202:
 			if (mvol < 1)
 				mvolumev = mvol + 0.05;
 			else
 				mvolumev = 1;
 			mvolumesv = ftos(mvolumev);
 			mvolumes = strcat("mastervolume ", mvolumesv, " \n");
 			cmd(mvolumes);
 			break;
 		case 203:
 			string effvolumes, effvolumesv;
 			float effvolumev;
 			if (effvol >= 0.05)
 				effvolumev = effvol - 0.05;
 			else
 				effvolumev = 0;
 			effvolumesv = ftos(effvolumev);
 			effvolumes = strcat("volume ", effvolumesv, " \n");
 			cmd(effvolumes);
 			break;
 		case 204:
 			if (effvol < 1)
 				effvolumev = effvol + 0.05;
 			else
 				effvolumev = 1;
 			effvolumesv = ftos(effvolumev);
 			effvolumes = strcat("volume ", effvolumesv, " \n");
 			cmd(effvolumes);
 			break;
 		case 205:
 			string bgmvolumes, bgmvolumesv;
 			float bgmvolumev;
 			if (bgmvol >= 0.05)
 				bgmvolumev = bgmvol - 0.05;
 			else
 				bgmvolumev = 0;
 			bgmvolumesv = ftos(bgmvolumev);
 			bgmvolumes = strcat("bgmvolume ", bgmvolumesv, " \n");
 			cmd(bgmvolumes);
 			break;
 		case 206:
 			if (bgmvol < 1)
 				bgmvolumev = bgmvol + 0.05;
 			else
 				bgmvolumev = 1;
 			bgmvolumesv = ftos(bgmvolumev);
 			bgmvolumes = strcat("bgmvolume ", bgmvolumesv, " \n");
 			cmd(bgmvolumes);
 			break;

 			//////////// VIDEO BUTTONS

 		case 250:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 960\n");
 			break;
 		case 251:
 			cmd("vid_width 1360\n");
 			cmd("vid_height 1024\n");
 			break;
 		case 252:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 1200\n");
 			break;
 		case 253:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1440\n");
 			break;
 		case 254:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1920\n");
 			break;
 		case 255:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 768\n");
 			break;
 		case 256:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 1024\n");
 			break;
 		case 257:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 1280\n");
 			break;
 		case 258:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 2048\n");
 			break;
 		case 259:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 720\n");
 			break;
 		case 260:
 			cmd("vid_width 1360\n");
 			cmd("vid_height 768\n");
 			break;
 		case 261:
 			cmd("vid_width 1366\n");
 			cmd("vid_height 768\n");
 			break;
 		case 262:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 900\n");
 			break;
 		case 263:
 			cmd("vid_width 1680\n");
 			cmd("vid_height 1050\n");
 			break;
 		case 264:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1080\n");
 			break;
 		case 265:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1440\n");
 			break;
 		case 266:
 			cmd("vid_width 3840\n");
 			cmd("vid_height 2160\n");
 			break;
 		case 267:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 800\n");
 			break;
 		case 268:
 			cmd("vid_width 1440\n");
 			cmd("vid_height 900\n");
 			break;
 		case 269:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1200\n");
 			break;
 		case 270:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1600\n");
 			break;
 		case 271:
 			cmd("vid_width 3840\n");
 			cmd("vid_height 2400\n");
 			break;
 			
 			case 272:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1080\n");
 			break;
 			case 273:
 			cmd("vid_width 3440\n");
 			cmd("vid_height 1440\n");
 			break;
 			case 274:
 			cmd("vid_width 5120\n");
 			cmd("vid_height 2160\n");
 			break;
 			
 		case 275:
 			menutype = M_TYPE_RESOLUTION;
 			cmd("vid_restart\n");
 			restart_consize();
 			refresh_mouse();
 			break;
 		case 276:
 			string vid_wres_s, vid_wres_s2;
 			vid_wres_s = ftos(vid_wres);
 			vid_wres_s2 = strcat("vid_width ", vid_wres_s, " \n");
 			cmd(vid_wres_s2);
 			string vid_hres_s, vid_hres_s2;
 			vid_hres_s = ftos(vid_hres);
 			vid_hres_s2 = strcat("vid_height ", vid_hres_s, " \n");
 			cmd(vid_hres_s2);
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 290:
 			float checked6;
 			checked6 = cvar("vid_vsync");
 			if (checked6 == 1)
 				cmd("vid_vsync 0\n");
 			else
 				cmd("vid_vsync 1\n");
 			break;
 		case 291:
 			string bright_s, bright_c;
 			float bright_f;
 			if (brightlev > 0.05)
 				bright_f = brightlev - 0.05;
 			else
 				bright_f = 0;
 			bright_s = ftos(bright_f);
 			bright_c = strcat("r_hdr_scenebrightness ", bright_s, " \n");
 			cmd(bright_c);
 			break;
 		case 292:
 			if (brightlev < 2)
 				bright_f = brightlev + 0.05;
 			else
 				bright_f = 2;
 			bright_s = ftos(bright_f);
 			bright_c = strcat("r_hdr_scenebrightness ", bright_s, " \n");
 			cmd(bright_c);
 			break;
 		case 293:
 			string gamma_s, gamma_c;
 			float gamma_f;
 			if (gammalev > 0.15)
 				gamma_f = gammalev - 0.05;
 			else
 				gamma_f = 0.1;
 			gamma_s = ftos(gamma_f);
 			gamma_c = strcat("v_gamma ", gamma_s, " \n");
 			cmd(gamma_c);
 			break;
 		case 294:
 			if (gammalev < 2)
 				gamma_f = gammalev + 0.05;
 			else
 				gamma_f = 2;
 			gamma_s = ftos(gamma_f);
 			gamma_c = strcat("v_gamma ", gamma_s, " \n");
 			cmd(gamma_c);
 			break;
 		case 295:
 			string cont_s, cont_c;
 			float cont_f;
 			if (contlev > 0.21)
 				cont_f = contlev - 0.1;
 			else
 				cont_f = 0.2;
 			cont_s = ftos(cont_f);
 			cont_c = strcat("v_contrast ", cont_s, " \n");
 			cmd(cont_c);
 			break;
 		case 296:
 			if (contlev < 2)
 				cont_f = contlev + 0.05;
 			else
 				cont_f = 2;
 			cont_s = ftos(cont_f);
 			cont_c = strcat("v_contrast ", cont_s, " \n");
 			cmd(cont_c);
 			break;
 		case 297:
 			string fov_s, fov_c;
 			float fov_f;
 			if (fovlev > 80)
 				fov_f = fovlev - 1;
 			else
 				fov_f = 80;
 			fov_s = ftos(fov_f);
 			fov_c = strcat("fov ", fov_s, " \n");
 			cmd(fov_c);
 			break;
 		case 298:
 			if (fovlev < 120)
 				fov_f = fovlev + 1;
 			else
 				fov_f = 120;
 			fov_s = ftos(fov_f);
 			fov_c = strcat("fov ", fov_s, " \n");
 			cmd(fov_c);
 			break;
 			//////// PIXEL SCALING
 		case 700:
 			cmd("r_viewscale 1\n");
 			break;
 		case 701:
 			cmd("r_viewscale 0.5\n");
 			break;
 		case 702:
 			cmd("r_viewscale 0.333\n");
 			break;
 		case 703:
 			cmd("r_viewscale 0.25\n");
 			break;
 		case 704:
 			cmd("r_viewscale 0.125\n");
 			break;
 			//////// ANISOTROPY FILTERING
 		case 303:
 			cmd("gl_texture_anisotropy 2\n");
 			break;
 		case 304:
 			cmd("gl_texture_anisotropy 4\n");
 			break;
 		case 305:
 			cmd("gl_texture_anisotropy 8\n");
 			break;
 		case 306:
 			cmd("gl_texture_anisotropy 16\n");
 			break;

 			//////// ANTIALIASING
 		case 307:
 			cmd("vid_samples 0\n");
 			break;
 		case 308:
 			cmd("vid_samples 2\n");
 			break;
 		case 309:
 			cmd("vid_samples 4\n");
 			break;
 		case 310:
 			cmd("vid_samples 8\n");
 			break;
 		case 311:
 			menutype = M_TYPE_VIDEO;
 			vid_aalias = cvar("vid_samples");
 			cmd("vid_restart\n");
 			break;
 		case 312:
 			string vid_aalias_s, vid_aalias_s2;
 			vid_aalias_s = ftos(vid_aalias);
 			vid_aalias_s2 = strcat("vid_samples ", vid_aalias_s, " \n");
 			cmd(vid_aalias_s2);
 			menutype = M_TYPE_VIDEO;
 			break;
 		case 314:
 			float checked7;
 			checked7 = cvar("r_fxaa");
 			if (checked7 == 1)
 				cmd("r_fxaa 0\n");
 			else
 				cmd("r_fxaa 1\n");
 			break;
 		case 315:
 			cmd("gl_texturemode gl_nearest\n");
 			cmd("saved2 0\n");
 			break;
 		case 316:
 			cmd("gl_texturemode gl_nearest_mipmap_linear\n");
 			cmd("saved2 1\n");
 			break;
 		case 317:
 			cmd("gl_texturemode gl_linear\n");
 			cmd("saved2 2\n");
 			break;
 		case 318:
 			float checked8;
 			checked8 = cvar("r_mipskins");
 			if (checked8 == 1)
 				cmd("r_mipskins 0\n");
 			else
 				cmd("r_mipskins 1\n");
 			break;
 		case 319:
 			float checked9;
 			checked9 = cvar("r_lerpmodels");
 			if (checked9 == 1)
 				cmd("r_lerpmodels 0\n");
 			else
 				cmd("r_lerpmodels 1\n");
 			break;
 		case 320:
 			float checked10;
 			checked10 = cvar("vid_fullscreen");
 			menutype = M_TYPE_CONFIRMFULLSCREEN;
 			if (checked10 == 1)
 				cmd("vid_fullscreen 0\n");
 			else
 				cmd("vid_fullscreen 1\n");
 			break;
 		case 321:
 			vid_fullscr = cvar("vid_fullscreen");
 			cmd("vid_restart\n");
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 322:
 			string vid_f_s, vid_f_s2;
 			vid_f_s = ftos(vid_fullscr);
 			vid_f_s2 = strcat("vid_fullscreen ", vid_f_s, " \n");
 			cmd(vid_f_s2);
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 323:
 			float checked11;
 			checked11 = cvar("r_glsl_postprocess");
 			if (checked11 == 1)
 				cmd("r_glsl_postprocess 0\n");
 			else
 				cmd("r_glsl_postprocess 1\n");
 			break;
 		case 324:
 			float checked12;
 			checked12 = cvar("r_dynamic");
 			if (checked12 == 1)
 				cmd("r_dynamic 0\n");
 			else
 				cmd("r_dynamic 1\n");
 			break;
 	}
 };
 