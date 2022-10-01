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


/*

global path "C:\Users\WB585318\WBG\Javier Romero - Panama\HFPS\LC2 presentation Ph2w2"
global data "$path\data"
global dos  "C:\Users\WB585318\OneDrive - Universidad de los Andes\WB\Git_repositories\HFS_WI-II_LC2"
global results "$path\results"
global w1 	"$data\Wave 1"
global w2 	"$data\Wave 2"

*/

global path "/Users/nicolas/Dropbox/World Bank/HFS"
global data "$path/data"
global dos "/Users/nicolas/Dropbox/Mac/Documents/GitHub/HFS_WI-II_LC2"
global results "$data/results"
global w1 "$data/Wave 1"
global w2 "$data/Wave 2"
set more off



*preserve				
	tempfile tablas
	tempname ptablas
	postfile `ptablas' str100(Country_id Country_name Wave Module Variable Indicator Cut) Value Numerator Demoninator using `tablas', replace

/*==================================================
              1: first wave 
==================================================*/

local countries 501 502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 876

foreach country of local countries {

use "$w1/`country'_PH2W1_CT_Casos", replace 
cap drop _merge
destring folio, replace force
save "$w1/`country'_PH2W1_CT_Casos", replace 
merge 1:1 folio using "$w1/`country'_PH2W1_CT_Ninos", force 
cap drop _merge 
destring folio, replace force
cap merge 1:1 folio using "$w1/Roster/hijos/`country'_PH2W1_RD_hijos", force 
destring folio, replace 
cap drop _merge 
save "$w1/`country'_PH2W1_CT_Casos", replace 
qui include "$dos/01. variables HFS WI.do" 

local wave w1
*--------------------------------indicators-------------------------------------


*Percentages 
local cuts total  
local variables income_red income_incr income_same income_eme_gov_pand fs_savings fs_rent_obligations fs_new_labor fs_child_labor /*
				*/income_reg_gov_prepand income_reg_gov_pand percep_inseg_violencia 
	foreach cut of local cuts{
		foreach variable of local variables {
		    include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w1] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
		}
	}
	
local cuts total urban rural male female primary_hh secondary_hh terciary_hh publico1 privado1 mixto1 elder /*0kid_0_5_hh kid_6_12_hh */	
 local variables attendance_6_17 attendance_prepan_6_17 oferta_presencial1 face_to_face_classes_6_17 attendance_prepan_1_5 attendance_1_5 learning_less learning_same run_out_food run_out_food_pre_pan aumento_v14_05 aumento_v14_06 I_hh_female I_hh_male N_hh_female N_hh_male
 
		foreach cut of local cuts{
			foreach variable of local variables {
		   
			include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w1] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
			}	
		}
		

local cuts total urban rural male female primary secondary terciary age_18_24 age_25_54 age_55_65 mother_0_5 hh_female hh_male	
 local variables activo1 activo0 ocu_pea0 ocu_pea1 ocupado1 ocupado0 ocu0_desoc1 ocu0_inac1 inac0_ocu1 desoc0_ocu1 perdida01 ganancia01 workhome lost hea2 heal3 hea4 hea6 hea7 hea8 aumento_v14_05 aumento_v14_06 I_hh_female I_hh_male N_hh_female N_hh_male t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 old_user new_user formal0 formal1 act0_formal1 act0_informal1 act0_desocupado1 act0_inac1 inac0_ac1 inac0_formal1 inac0_informal1 inac0_unemp1 aumento_dom aumento_childcare aumento_acomp

 
		foreach cut of local cuts{
			foreach variable of local variables {
		   
			include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w1] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
			}	
		}	

local cuts total urban rural male female primary secondary terciary age_18_24 age_25_54 age_55_65 mother_0_5 hh_female hh_male	
 local variables horas0 horas1

 
		foreach cut of local cuts{
			foreach variable of local variables {
		   
			include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w1] if `cut'==1
			local value = r(mean)
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
			}	
		}	
		
*Percentage point change 


 local cut total 
 local variable regular_CCT
 local variable1 income_reg_gov_prepand
 local variable2 income_reg_gov_pand
		qui include "$dos/03. formats.do"
		sum `variable1' [iw=w_hh_ph2w1], meanonly
		local prepan = r(mean)*100
		sum `variable2' [iw=w_hh_ph2w1], meanonly
		local pan = r(mean)*100
	
		local value = `pan' - `prepan'
		post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (.) (.)

 local cut total 
 local variable pp_attendance 
 local variable1 attendance_prepan_6_17
 local variable2 attendance_6_17
 
		qui include "$dos/03. formats.do"
		sum `variable1' [iw=w_hh_ph2w1], meanonly
		local prepan = r(mean)*100
		sum `variable2' [iw=w_hh_ph2w1], meanonly
		local pan = r(mean)*100
	
		local value = `pan' - `prepan'
		post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (.) (.)
 		
		
 local cuts total urban rural male female primary secondary terciary age_18_24 age_25_54 age_55_65 mother_0_5 hh_female hh_male
 local variable pp_formal
 local variable1 formal0
 local variable2 formal1
 
 foreach cut of local cuts{
		qui include "$dos/03. formats.do"
		sum `variable1' [iw=w_hh_ph2w1], meanonly
		local prepan = r(mean)*100
		sum `variable2' [iw=w_hh_ph2w1], meanonly
		local pan = r(mean)*100
	
		local value = `pan' - `prepan'
		post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (.) (.)
 }		
				
}

/*==================================================
              2: second wave 
==================================================*/

local countries 501 502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 876

foreach country of local countries {

use "$w2/`country'_PH2W2_CP_Casos", replace 
merge 1:1 folio using "$w2/`country'_PH2W2_CP_Ninos", force 
drop _merge 
cap merge 1:1 folio using "$w2/Roster/hijos/`country'_PH2W2_RD_hijos", force 
drop _merge 
destring folio, replace 
merge 1:1 folio using "$w1/`country'_PH2W1_CT_Casos", keepusing(u04_04 u05* u07* u12* u09_06 u09_08 u09_09)
qui include "$dos/02. variables HFS WII.do"
local wave w2

* Percentages 
local cuts total 
local variables income_red income_incr income_same income_eme_gov_pand fs_savings fs_rent_obligations fs_new_labor fs_child_labor /*
				*/ income_reg_gov_prepand income_reg_gov_pand percep_inseg_violencia  

	foreach cut of local cuts{
		foreach variable of local variables {
		    
			qui include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w2] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
		}
	}
* with cuts 	
local cuts total urban rural male female primary_hh secondary_hh terciary_hh publico1 privado1 mixto1 elder hh_female hh_male	/* kid_0_5_hh kid_6_12_hh */
local variables attendance_6_17 face_to_face_classes_6_17 oferta_presencial1 attendance_prepan_6_17 attendance_prepan_1_5 attendance_1_5 learning_less learning_same run_out_food run_out_food_pre_pan aumento_v14_05 aumento_v14_06 I_hh_female I_hh_male N_hh_female N_hh_male		
		foreach cut of local cuts{
			foreach variable of local variables {
		    
			qui include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w2] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
			}	
		}
		
local cuts total urban rural male female primary secondary terciary age_18_24 age_25_54 age_55_65 mother_0_5 hh_female hh_male		
 local variables activo1 activo0 ocu_pea0 ocu_pea1 ocupado1 ocupado0 ocu0_desoc1 ocu0_inac1 inac0_ocu1 desoc0_ocu1 perdida01 ganancia01 workhome lost aumento_dom aumento_childcare aumento_acomp toma_dec_gasto0 toma_dec_gasto1 hea2 heal3 hea4 hea9 hea10 hea6 hea7 hea8 aumento_v14_05 aumento_v14_06 I_hh_female I_hh_male N_hh_female N_hh_male t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20  /*
		*/  old_user new_user formal0 formal1 act0_formal1 act0_informal1 act0_desocupado1 act0_inac1 inac0_ac1 inac0_formal1 inac0_informal1 inac0_unemp1
 
		foreach cut of local cuts{
			foreach variable of local variables {
		   
			include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w2] if `cut'==1
			local value = r(mean)*100
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
			}	
		}	
		
local cuts total urban rural male female primary secondary terciary age_18_24 age_25_54 age_55_65 mother_0_5 hh_female hh_male	
 local variables horas0 horas1

		foreach cut of local cuts{
			foreach variable of local variables {
		   
			include "$dos/03. formats.do"
			sum `variable' [iw=w_hh_ph2w2] if `cut'==1
			local value = r(mean)
			local numer = r(sum)
			local denom = r(sum_w)
			post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer') (`denom') 
			}	
		}	
		
*Percentage point change 
		
*Percentage point change  fr

 local cut total 
 local variable regular_CCT
 local variable1 income_reg_gov_prepand
 local variable2 income_reg_gov_pand
		qui include "$dos/03. formats.do"
		sum `variable1' [iw=w_hh_ph2w2], meanonly
		local prepan = r(mean)*100
		sum `variable2' [iw=w_hh_ph2w2], meanonly
		local pan = r(mean)*100
	
		local value = `pan' - `prepan'
		post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (.) (.)

 local cut total 
 local variable pp_attendance 
 local variable1 attendance_prepan_6_17
 local variable2 attendance_6_17
 
		qui include "$dos/03. formats.do"
		sum `variable1' [iw=w_hh_ph2w2], meanonly
		local prepan = r(mean)*100
		sum `variable2' [iw=w_hh_ph2w2], meanonly
		local pan = r(mean)*100
	
		local value = `pan' - `prepan'
		post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (.) (.)
 			
		
local cuts total urban rural male female primary secondary terciary age_18_24 age_25_54 age_55_65 mother_0_5 hh_female hh_male	
 local variable pp_formal
 local variable1 formal0
 local variable2 formal1
 
 foreach cut of local cuts{
		qui include "$dos/03. formats.do"
		sum `variable1' [iw=w_hh_ph2w2], meanonly
		local prepan = r(mean)*100
		sum `variable2' [iw=w_hh_ph2w2], meanonly
		local pan = r(mean)*100
	
		local value = `pan' - `prepan'
		post `ptablas' ("`country'") ("`name'") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (.) (.)
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
	postfile `ptablas1' str100(Country_id Country_name Wave Module Variable Indicator Cut) Value Numerator Demoninator using `tablas1', replace

	
	*use `tablas'
    local waves w1 w2 
	local cuts total urban rural male female primary_hh secondary_hh terciary_hh publico1 privado1 mixto1 primary secondary terciary age_18_24 age_25_54 age_55_65 hh_female hh_male
	local variables income_red income_incr income_same income_eme_gov_pand fs_savings fs_rent_obligations fs_new_labor fs_child_labor /*
	                */ run_out_food run_out_food_pre_pan income_reg_gov_prepand income_reg_gov_pand percep_inseg_violencia aumento_v14_05 /*
					*/ aumento_v14_06 attendance_6_17 face_to_face_classes_6_17 attendance_prepan_6_17 attendance_prepan_1_5 attendance_1_5 /*       		    */ learning_less learning_same regular_CCT perdida01 ganancia01 workhome lost aumento_dom aumento_childcare aumento_acomp toma_dec_gasto0 toma_dec_gasto1 /* 
					*/ hea2 heal3 hea4 hea9 hea10 hea6 hea7 hea8 aumento_v14_05 aumento_v14_06 I_hh_female I_hh_male N_hh_female N_hh_male t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo sector1 sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 old_user new_user  activo1 activo0 ocu_pea0 ocu_pea1 ocupado1 ocupado0 ocu0_desoc1 inac0_ocu1 desoc0_ocu1 /*
					*/ ocu0_inac1 oferta_presencial1 formal0 formal1 act0_formal1 act0_informal1 act0_desocupado1 act0_inac1 inac0_ac1 inac0_formal1 inac0_informal1 inac0_unemp1
	

	
	foreach wave of local waves {
		foreach cut of local cuts {
			foreach variable of local variables { 
			
			qui include "$dos/03. formats.do"
			sum Numerator if  Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'"
			local numer = r(sum)
			sum Demoninator if  Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'"
			local denom = r(sum)
			local value = ( `numer' / `denom' ) *100
			sum Value  if Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'"
			local mean_lac = r(mean)
			
			post `ptablas1' ("LAC_W") ("LAC_W") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer')  (`denom') 
			post `ptablas1' ("LAC_S") ("LAC_S") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`mean_lac') (`numer')  (`denom') 
			}
	
			
		}
	}
	local waves w1 w2 
	local cuts total urban rural male female primary_hh secondary_hh terciary_hh publico1 privado1 mixto1 primary secondary terciary age_18_24 age_25_54 age_55_65 hh_female hh_male
	local variables horas0 horas1
	foreach wave of local waves {
		foreach cut of local cuts {		
			foreach variable of local variables { 
			qui include "$dos/03. formats.do"
			sum Numerator if  Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'"
			local numer = r(sum)
			sum Demoninator if  Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'"
			local denom = r(sum)
			local value = ( `numer' / `denom' ) 
			sum Value  if Wave=="`wave'" & Variable=="`variable'" & Cut=="`cut'"
			local mean_lac = r(mean)
			
			post `ptablas1' ("LAC_W") ("LAC_W") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`value') (`numer')  (`denom') 
			post `ptablas1' ("LAC_S") ("LAC_S") ("`wave'") ("`module'") ("`variable'") ("`label'") ("`cut'") (`mean_lac') (`numer')  (`denom') 
			}
		}
	}	
	
	
	postclose `ptablas1'
	use `tablas1', clear
	save `tablas1', replace 
	append using `tablas'
	
cap export excel using "${results}/00.HFPS.xlsx", sh("indicadores", replace)  firstrow(var)

cap export excel using "$results/HFPS_NS.xls", sh("indicadores", replace)  firstrow(var)

export excel using "/Users/nicolas/Dropbox/World Bank/HFS/results/HFPS_NS.xls", sheet("indicadores") sheetmodify firstrow(variables) nolabel

*restore



/*==================================================
              3: LC2 average 
==================================================*/


