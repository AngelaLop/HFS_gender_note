/*==================================================
project:       
Author:        Angela Lopez 
E-email:       alopezsanchez@worldbank.org
url:           
Dependencies:  
----------------------------------------------------
Creation Date:     4 May 2022 - 16:03:54
Modification Date:   
Do-file version:    01
References:          
Output:             
==================================================*/

/*==================================================
              0: Program set up
==================================================*/
drop _all




global pathdata "C:\Users\WB585318\WBG\Javier Romero - Panama\HFPS\LC2 presentation Ph2w2"
global data1 "C:\Users\WB585318\WBG\LAC High Frequency Phone Survey v.2 - WB Group - PE Shared Folder\Data"
global data "$pathdata\data"
global pathppt "C:\Users\WB585318\WBG\Javier Romero - HFS gender\02 Note p2w2"
global dos  "$pathppt\do.files\HFS_gender_note"
global results "$pathppt\excel resume"
global w1 	"$data\Wave 1"
global w2 	"$data\Wave 2"
global dw1 	"$data1\Wave 1"
global dw2 	"$data1\Wave 2"

/*
global path "/Users/nicolas/Dropbox/World Bank/HFS"
global data "$path/data"
global dos "/Users/nicolas/Dropbox/Mac/Documents/GitHub/HFS_WI-II_LC2"
global results "$data/results"
global w1 "$data/Wave 1"
global w2 "$data/Wave 2"
set more off




local countries 501 502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 876
foreach country of local countries {
	use "$dw1/`country'_PH2W1_CT_Casos", replace 
	destring folio, replace
	save "$w1/`country'_PH2W1_CT_Casos", replace 
	
	use "$dw1/`country'_PH2W1_CT_Ninos", replace 
	destring folio, replace
	save "$w1/`country'_PH2W1_CT_Ninos", replace 
	
	
}
*/

*preserve				
	tempfile tablas
	tempname ptablas
	postfile `ptablas' str100(Country_id Country_name Wave Module Variable Indicator Cut Sex) Value Numerator Demoninator using `tablas', replace

/*==================================================
              1: first wave 
==================================================*/

local countries 876 501 502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 

foreach country of local countries {

use "$w1/`country'_PH2W1_CT_Casos", replace 
merge 1:1 folio using "$w1/`country'_PH2W1_CT_Ninos", force 
cap drop _merge 

cap merge 1:1 folio using "$w1/Roster/hijos/`country'_PH2W1_RD_hijos", force 
destring folio, replace 
cap drop _merge 
save "$w1/`country'_PH2W1_CT_Casos_total", replace 
qui include "$dos/01. variables HFS WI.do" 







local wave w1
*--------------------------------indicators-------------------------------------

	
local cuts total male female partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary
 local variables   /*
				 */ ocupado1 ocupado0 formal0 formal1 ganancia01 perdida01 horas0 horas1/*
				 */ ocupado1_e ocupado0_e activo1 activo0 activo1_e activo0_e inactivo1_e inactivo0_e formal0_e formal1_e ganancia01_e perdida01_e horas0_e horas1_e/*
				 */ hea2 heal3 hea4 hea5 hea9 hea10 hea6 hea7 hea8 /*
				 */ aumento_v14_05 aumento_v14_06 /*
				 */  t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo inac0_ac1 /*
				 */ sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 sector_before7 sector_before8 /*
				 */ sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 sector_before14 sector_before15 /*
				 */ sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector1 sector2 sector3 sector4 /*
				 */ sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 /*
				 */ sector18 sector19 sector20 /*
				 */ aumento_dom aumento_childcare aumento_acomp income_red income_not_better face_to_face_classes_6_17 learning_less

 
	local sexos total male female 	
		foreach cut of local cuts{
			foreach sexo of local sexos {
				foreach variable of local variables {
				
				   ** nivel individual 
					include "$dos/03. formats.do"
					sum `variable' [iw=w_ind_ph2w1] if `cut'==1 & `sexo'==1
					local value = r(mean)*100
					local numer = r(sum)
					local denom = r(sum_w)
					post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("`sexo'") (`value') (`numer') (`denom') 
			
				
				}
			}	
		}
			
			local cuts total male female 
			local variables hh_female_n hh_male_n hh_female hh_male	
			
		foreach cut of local cuts {	
			foreach variable of local variables {
		
		** nivel individual 
			include "$dos/03. formats.do"
			sum `variable' [iw=w_ind_ph2w1] if `cut'==1 & `variable'==1
			local value = r(N)
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("Total") (`value') (`numer') (`denom') 
			}	
			
		}	
		
local cuts total hh_female hh_male hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male		
 local variables   /*
				*/ ocupado1 ocupado0 formal0 formal1 ganancia01 perdida01 horas0 horas1/*
				*/ aumento_dom aumento_childcare aumento_acomp toma_dec_gasto0 toma_dec_gasto1/*
				*/ hea2 heal3 hea4 hea5 hea9 hea10 hea6 hea7 hea8 /*
				*/ aumento_v14_06 aumento_v14_05 /*
				*/ income_red income_not_better
			
			
				
			
			** nivel hogar 
		foreach cut of local cuts{
			foreach variable of local variables {	
		   
			include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w1] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("Total") (`value') (`numer') (`denom') 
			}	
		}	
		
}		



/*==================================================
              2: second wave 
==================================================*/

local countries 507 876 501 502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 

foreach country of local countries {

use "$dw2/`country'_PH2W2_CP_Casos", replace 
merge 1:1 folio using "$w2/`country'_PH2W2_CP_Ninos", force 
drop _merge 
merge 1:1 folio using "$w2/Roster/hijos/`country'_PH2W2_RD_hijos", force 
drop _merge 
destring folio, replace 
*joinby folio using "$w1/`country'_PH2W1_CT_Casos", keepusing(u04_04 u05* u07* u12* u09_06 u09_08 u09_09)
joinby folio using "$w1/`country'_PH2W1_CT_Casos", unmatched(both)  
drop if _merge==2
*save "$w2/`country'_PH2W2_CP_Casos", replace 

include "$dos/02. variables HFS WII.do"

}


local wave w2

		
local cuts total partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary		
 local variables ocupado1 ocupado0 formal0 formal1 ganancia01 perdida01 horas0 horas1 /*
				*/ ocupado1_e ocupado0_e activo1_e activo1 activo0 activo0_e inactivo1_e inactivo0_e formal0_e formal1_e ganancia01_e perdida01_e horas0_e horas1_e /*
				*/ aumento_dom aumento_childcare aumento_acomp toma_dec_gasto0 toma_dec_gasto1 /*
				*/ hea2 heal3 hea4 hea5 hea9 hea10 hea6 hea7 hea8 /*
				*/ aumento_v14_06 aumento_v14_05 /*
				*/ t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo t_fuera_informal t_fuera_formal int_head inac0_ac1/*
				*/ sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 /*
				*/ sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 /*
				*/ sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector1 /*
				*/ sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20  /*
				*/ face_to_face_classes_6_17 learning_less /*
				*income_red income_incr income_same income_red_bp income_same_bp income_incr_bp income_red_to_red income_red_to_same income_red_to_incr income_same_to_red income_same_to_same income_same_to_incr income_incr_to_red income_incr_to_same income_incr_to_incr */
				
	local sexos total male female 	
		foreach cut of local cuts{
			foreach sexo of local sexos {
				foreach variable of local variables {
				
				   ** nivel individual 
					include "$dos/03. formats.do"
					sum `variable' [iw=w_ind_ph2w2] if `cut'==1 & `sexo'==1
					local value = r(mean)*100
					local numer = r(sum)
					local denom = r(sum_w)
					post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("`sexo'") (`value') (`numer') (`denom') 
			
				
				}
			}	
		}
		
			local cuts total hh_female hh_male 
			local variables total female male hh_female_r hh_male_r 			
			
		foreach cut of local cuts {
			foreach variable of local variables {
				
		   ** nivel individual 
			include "$dos/03. formats.do"
			sum `variable' [iw=w_ind_ph2w2] if `cut'==1 
			local value = r(mean)*100
			local numer = r(sum) 
			local denom = r(N)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("Total") (`value') (`numer') (`denom') 
			}	
			
		}	

local cuts total hh_female hh_male hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male I_hh_female_m I_hh_male_m 	
 local variables 
				*/ ocupado1 ocupado0 formal0 formal1 ganancia01 perdida01 horas0 horas1/*
				*/ aumento_dom aumento_childcare aumento_acomp toma_dec_gasto0 toma_dec_gasto1/*
				*/ hea2 heal3 hea4 hea5 hea9 hea10 hea6 hea7 hea8 /*
				*/ aumento_v14_06 aumento_v14_05 /*
				*/ income_red income_incr income_same income_red_bp income_same_bp income_incr_bp income_red_to_red income_red_to_same income_red_to_incr income_same_to_red income_same_to_same income_same_to_incr income_incr_to_red income_incr_to_same income_incr_to_incr 
				
			** nivel hogar 
			foreach cut of local cuts {
			foreach variable of local variables {
		   
			include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w2] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("Total") (`value') (`numer') (`denom') 
			}	
		}	
		
local cuts total hh_female hh_male hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male I_hh_female_m I_hh_male_m female male		
 local variables reconnected
				
			** nivel hogar 
			foreach cut of local cuts {
			foreach variable of local variables {
		   
			include "$dos/03. formats.do"
			sum `variable'  if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("Total") (`value') (`numer') (`denom') 
			}	
		}	
		
		
}

	
postclose `ptablas'
use `tablas', clear
save `tablas', replace 


/*==================================================
              4: LAC average 
==================================================*/


	tempfile tablas1
	tempname ptablas1
	postfile `ptablas1' str100(Country_id Country_name Wave Module Variable Indicator Cut Sex) Value Numerator Demoninator using `tablas1', replace

	
	*use `tablas'
    local waves w1 w2 
	local cuts total partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary
	local sexos total male female
	local variables  
					*/ ocupado1 ocupado0 formal0 formal1 ganancia01 perdida01 horas0 horas1/*
					*/ ocupado1_e ocupado0_e activo1_e activo1 activo0 activo0_e inactivo1_e inactivo0_e formal0_e formal1_e ganancia01_e perdida01_e horas0_e horas1_e/*
					*/ aumento_dom aumento_childcare aumento_acomp toma_dec_gasto0 toma_dec_gasto1/*
					*/ hea2 heal3 hea4 hea5 hea9 hea10 hea6 hea7 hea8 /*
					*/ aumento_v14_06 aumento_v14_05 face_to_face_classes_6_17 /*
					*/ t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo t_fuera_informal t_fuera_formal int_head inac0_ac1 /*
					*/ sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 /*
					*/ sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 /*
					*/ sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector1 /*
					*/ sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20  /*
					*/ income_red income_not_better income_incr income_same income_red_bp income_same_bp income_incr_bp income_red_to_red income_red_to_same income_red_to_incr income_same_to_red income_same_to_same income_same_to_incr income_incr_to_red income_incr_to_same income_incr_to_incr /*
					*/ female male hh_male hh_female_r hh_male_r reconnected face_to_face_classes_6_17 learning_less
					
	

	
	foreach wave of local waves {
		foreach cut of local cuts {
			foreach sexo of local sexos {
				foreach variable of local variables { 
			
					qui include "$dos/03. formats.do"
					sum Numerator if  Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'" & Sex=="`sexo'" 
					local numer = r(sum)
					sum Demoninator if  Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'" & Sex=="`sexo'" 
					local denom = r(sum)
					local value = ( `numer' / `denom' ) *100
					sum Value  if Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'" & Sex=="`sexo'" 
					local mean_lac = r(mean)
					
					post `ptablas1' ("LAC_W") ("LAC_W") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("`sexo'") (`value') (`numer')  (`denom') 
					post `ptablas1' ("LAC_S") ("LAC_S") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("`sexo'") (`mean_lac') (`numer')  (`denom') 
			
				}
			}
		}
/*	
	local wave w1 w2
	local cuts total parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary
	local sexos total male female
		
	
	foreach wave of local waves {	
		foreach cut of local cuts {
			foreach sexo of local sexos {

				
				cap replace ocupado_pre  = Value if  Wave=="`wave'" & Variable=="ocupado0_e" & Cut=="`cut'" & Sex=="`sexo'" 
				cap replace  ocpuado_post = Value if  Wave=="`wave'" & Variable=="ocupado1_e" & Cut=="`cut'" & Sex=="`sexo'"
				local pre ocupado0_e
				local pos ocupado1_e
				
				cap mean  ocpuado_post ocupado_pre if Wave=="`wave'" & Cut=="`cut'" & Sex=="`sexo'"
				test  ocpuado_post = ocupado_pre
				local pval = r(p)
				di `pval'

				
			}
		}
	}
	
				
				post `ptablas1' ("LAC_W") ("LAC_W") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("`sexo'") (`value') (`numer')  (`denom') 
				post `ptablas1' ("LAC_S") ("LAC_S") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") ("`sexo'") (`mean_lac') (`numer')  (`denom') 
	*/
	
	}
	
	
	
	postclose `ptablas1'
	use `tablas1', clear
	save `tablas1', replace 
	append using `tablas'
	
cap export excel using "${results}/00.HFPS.xlsx", sh("indicadores", replace)  firstrow(var)

*cap export excel using "$results/HFPS_NS.xls", sh("indicadores", replace)  firstrow(var)

*export excel using "/Users/nicolas/Dropbox/World Bank/HFS/results/HFPS_NS.xls", sheet("Nuevos Indicadores") sheetmodify firstrow(variables) nolabel

*restore

