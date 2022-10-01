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
global data "$pathdata\data"
global pathppt "C:\Users\WB585318\WBG\Javier Romero - HFS gender\02 Note p2w2"
global dos  "$pathppt\do.files\HFS_gender_note"
global results "$pathppt\excel resume"
global w1 	"$data\Wave 1"
global w2 	"$data\Wave 2"



*preserve				
	tempfile tablas
	tempname ptablas
	postfile `ptablas' str100(Country_id Country_name Wave Module Variable Indicator Cut Sex) Prepandemia Postpandemia Pvalue using `tablas', replace

/*==================================================
              1: first wave 
==================================================*/

local countries 501 502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 876

foreach country of local countries {

use "$w1/`country'_PH2W1_CT_Casos", replace 
qui include "$dos/01. variables HFS WI.do" 
cap keep pais ocupado1_e ocupado0_e activo1_e activo0_e inactivo1_e inactivo0_e formal0_e formal1_e ganancia01_e perdida01_e horas0_e horas1_e total male female partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary w_ind_ph2w1 	sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 /*
				*/ sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 /*
				*/ sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector1 /*
				*/ sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 /* 
				*/ s_health s_education s_agriculture s_industry s_construction s_trade s_restaurants s_domestic s_transport s_arts s_publicadm s_financial /*
				*/s_health_pre s_education_pre s_agriculture_pre s_industry_pre s_construction_pre s_trade_pre s_restaurants_pre s_domestic_pre s_transport_pre s_arts_pre s_publicadm_pre s_financial_pre /*
				*/ t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo t_fuera_informal t_fuera_formal  
				
save "$w1/`country'_PH2W1_CT_Casos1", replace 

}


use "$w1/501_PH2W1_CT_Casos1", clear 

local countries  502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 876
foreach country of local countries {

append using "$w1/`country'_PH2W1_CT_Casos1" , force 

}
save "$w1/LAC_PH2W1_CT_Casos1", replace 

preserve 
gen ano = 2020
keep pais ocupado0_e activo0_e inactivo0_e formal0_e horas0_e total male female partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary w_ind_ph2w1 ano sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 /*
				*/ sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 /*
				*/ sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 /*
				*/ s_health_pre s_education_pre s_agriculture_pre s_industry_pre s_construction_pre s_trade_pre s_restaurants_pre s_domestic_pre s_transport_pre s_arts_pre s_publicadm_pre s_financial_pre 



rename ocupado0_e  ocupado 
rename activo0_e   activo 
rename inactivo0_e inactivo
rename formal0_e   formal 
rename horas0_e    horas 
rename sector_before1  sector1          
rename sector_before2  sector2
rename sector_before3 sector3
rename sector_before4 sector4
rename sector_before5 sector5
rename sector_before6 sector6
rename sector_before7 sector7
rename sector_before8 	sector8
rename sector_before9 sector9
rename sector_before10 	sector10
rename sector_before11 	sector11
rename sector_before12  sector12
rename sector_before13 	sector13
rename sector_before14 	sector14
rename sector_before15 sector15
rename sector_before16 	sector16
rename sector_before17 sector17
rename sector_before18 	sector18
rename sector_before19 sector19
rename sector_before20 	sector20
rename s_health_pre s_health
rename s_education_pre s_education 
rename s_agriculture_pre s_agriculture
rename s_industry_pre s_industry
rename s_construction_pre s_construction
rename s_trade_pre s_trade
rename s_restaurants_pre s_restaurants
rename s_domestic_pre s_domestic
rename s_transport_pre s_transport
rename s_arts_pre s_arts
rename s_publicadm_pre s_publicadm
rename s_financial_pre s_financial

save "$w1/LAC_PH2W1_CT_Casos12020", replace  
restore 

*preserve 
gen ano = 2021
keep pais ocupado1_e activo1_e inactivo1_e formal1_e ganancia01_e perdida01_e horas1_e total male female partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary w_ind_ph2w1 ano /*
				*/ sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 /*
				*/ s_health s_education s_agriculture s_industry s_construction s_trade s_restaurants s_domestic s_transport s_arts s_publicadm s_financial t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo t_fuera_informal t_fuera_formal   


rename ocupado1_e  ocupado 
rename activo1_e   activo 
rename inactivo1_e inactivo 
rename formal1_e   formal 
rename horas1_e    horas 
save "$w1/LAC_PH2W1_CT_Casos12021", replace  
append using "$w1/LAC_PH2W1_CT_Casos12020" 
save "$w1/LAC_PH2W1_CT_Casos1_LAC_completo", replace 



*--------------------------------indicators-------------------------------------

	local wave w1	
	local cuts age_18_24 age_25_54 age_55_65 primary secondary terciary
	
	local sexos total male female 	
	
	
	
		foreach cut of local cuts{
			foreach sexo of local sexos {
				
				
				foreach variable of local variables {
				
				
				   ** nivel individual 
					qui include "$dos/03. formats.do"
					mean `cut' [iw=w_ind_ph2w1] if `sexo'==1 & `variable'==1, over(ano)
					matrix list r(table)
					local pre = r(table)[1,1] *100
					local post = r(table)[1,2] * 100					
					test c.`cut'@2020.ano=c.`cut'@2021.ano
					local pval = r(p)
					
					post `ptablas' ("LAC") ("LAC") ("`wave'") ("`module'") ("`variable'") ("share of") ("`cut'") ("`sexo'") (`pre') (`post') (`pval') 
					
				}	
			}
		}
			
			
					local variables ocupado sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 formal horas ganancia01_e perdida01_e
					local anos 2021 2020
		foreach cut of local cuts{
			foreach sexo of local sexos {
					foreach variable of local variables {
						foreach ano of local anos {
							
										
					sum `variable' [iw=w_ind_ph2w1] if `cut'==1 & `sexo'==1 & `ano' == ano 
					local value = r(mean)*100
					local numer = r(sum)
					local denom = r(sum_w)
					post `ptablas' ("LAC") ("LAC") ("`wave'") ("`module'") ("`variable'") ("`ano'") ("`cut'") ("`sexo'") (`value') (`numer') (`denom') 	
						
						}
						}
			}	
		}
			

		

/*==================================================
              2: second wave 
==================================================*/

local countries 501 502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 876

foreach country of local countries {

use "$w2/`country'_PH2W2_CT_Casos", replace 
include "$dos/02. variables HFS WII.do"
cap keep pais ocupado1_e ocupado0_e activo1_e activo0_e inactivo1_e inactivo0_e formal0_e formal1_e ganancia01_e perdida01_e horas0_e horas1_e total male female partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary w_ind_ph2w2 age_18_24_pre age_25_54_pre age_55_65_pre sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 /*
				*/ sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 /*
				*/ sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 sector1 /*
				*/ sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 /*
				*/ s_health s_education s_agriculture s_industry s_construction s_trade s_restaurants s_domestic s_transport s_arts s_publicadm s_financial /*
				 */s_health_pre s_education_pre s_agriculture_pre s_industry_pre s_construction_pre s_trade_pre s_restaurants_pre s_domestic_pre s_transport_pre s_arts_pre s_publicadm_pre s_financial_pre /*
				 */ t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo t_fuera_informal t_fuera_formal  
save "$w2/`country'_PH2W2_CT_Casos2", replace 

}


use "$w2/501_PH2W2_CT_Casos2", clear 

local countries  502 503 504 505 506 507 509 510 520 540 560 570 591 592 593 595 598 758 767 809 876
foreach country of local countries {

append using "$w2/`country'_PH2W2_CT_Casos2" 

}
save "$w2/LAC_PH2W2_CT_Casos2", replace 

preserve 
gen ano = 2020
keep pais ocupado0_e activo0_e inactivo0_e formal0_e horas0_e total male female partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24_pre age_25_54_pre age_55_65_pre primary secondary terciary w_ind_ph2w2 ano sector_before1 sector_before2 sector_before3 sector_before4 sector_before5 sector_before6 /*
				*/ sector_before7 sector_before8 sector_before9 sector_before10 sector_before11 sector_before12 sector_before13 /*
				*/ sector_before14 sector_before15 sector_before16 sector_before17 sector_before18 sector_before19 sector_before20 /*
				*/ s_health_pre s_education_pre s_agriculture_pre s_industry_pre s_construction_pre s_trade_pre s_restaurants_pre s_domestic_pre s_transport_pre s_arts_pre s_publicadm_pre s_financial_pre

rename ocupado0_e    	ocupado 
rename activo0_e     	activo 
rename inactivo0_e   	inactivo
rename formal0_e     	formal 
rename horas0_e      	horas 
rename age_18_24_pre 	age_18_24
rename age_25_54_pre 	age_25_54
rename age_55_65_pre 	age_55_65
rename sector_before1  sector1          
rename sector_before2  sector2
rename sector_before3 sector3
rename sector_before4 sector4
rename sector_before5 sector5
rename sector_before6 sector6
rename sector_before7 sector7
rename sector_before8 	sector8
rename sector_before9 sector9
rename sector_before10 	sector10
rename sector_before11 	sector11
rename sector_before12  sector12
rename sector_before13 	sector13
rename sector_before14 	sector14
rename sector_before15 sector15
rename sector_before16 	sector16
rename sector_before17 sector17
rename sector_before18 	sector18
rename sector_before19 sector19
rename sector_before20 	sector20
rename s_health_pre s_health
rename s_education_pre s_education 
rename s_agriculture_pre s_agriculture
rename s_industry_pre s_industry
rename s_construction_pre s_construction
rename s_trade_pre s_trade
rename s_restaurants_pre s_restaurants
rename s_domestic_pre s_domestic
rename s_transport_pre s_transport
rename s_arts_pre s_arts
rename s_publicadm_pre s_publicadm
rename s_financial_pre s_financial

save "$w2/LAC_PH2W2_CT_Casos22020", replace  
restore 


gen ano = 2021
keep pais ocupado1_e activo1_e inactivo1_e formal1_e ganancia01_e perdida01_e horas1_e total male female partnered_f unpartnered_f hh_female hh_male I_hh_female I_hh_male N_hh_female N_hh_male parent no_parent age_18_24 age_25_54 age_55_65 primary secondary terciary w_ind_ph2w2 ano  /*
				*/ sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 /*
				*/ s_health s_education s_agriculture s_industry s_construction s_trade s_restaurants s_domestic s_transport s_arts s_publicadm s_financial /*
				*/ t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo t_fuera_informal t_fuera_formal  
				
rename ocupado1_e ocupado 
rename activo1_e  activo 
rename inactivo1_e inactivo 
rename formal1_e   formal 
rename horas1_e    horas 
save "$w2/LAC_PH2W2_CT_Casos22021", replace  
append using "$w2/LAC_PH2W2_CT_Casos22020", force 
save "$w2/LAC_PH2W2_CT_Casos2_LAC_completo", replace 
use "$w2/LAC_PH2W2_CT_Casos2_LAC_completo", clear  





local wave w2
	local cuts female age_18_24 age_25_54 age_55_65 primary secondary terciary parent
	local variables ocupado activo inactivo
	local sexos total male female 	
	
	
	
		foreach cut of local cuts{
			foreach sexo of local sexos {
				foreach variable of local variables {
				
				
				   ** nivel individual 
					qui include "$dos/03. formats.do"
					mean `cut' [iw=w_ind_ph2w2] if `sexo'==1 & `variable'==1, over(ano)
					matrix list r(table)
					local pre = r(table)[1,1] *100
					local post = r(table)[1,2] * 100					
					test c.`cut'@2020.ano=c.`cut'@2021.ano
					local pval = r(p)
					
					post `ptablas' ("LAC") ("LAC") ("`wave'") ("`module'") ("`variable'") ("share of") ("`cut'") ("`sexo'") (`pre') (`post') (`pval') 
					
				}		
			}
		}
			
			
					local variables ocupado sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 sector11 sector12 sector13 sector14 sector15 sector16 sector17 sector18 sector19 sector20 s_health s_education s_agriculture s_industry s_construction s_trade s_restaurants s_domestic s_transport s_arts s_publicadm s_financial t_formal_informal t_formal_desocupado t_formal_inactivo t_informal_formal t_informal_desocupado t_informal_inactivo t_fuera_informal t_fuera_formal formal horas ganancia01_e perdida01_e
					local anos 2021 2020
		
		foreach cut of local cuts{
			foreach sexo of local sexos {
					foreach variable of local variables {
						foreach ano of local anos {
							
										
					sum `variable' [iw=w_ind_ph2w2] if `cut'==1 & `sexo'==1 & `ano' == ano 
					local value = r(mean)*100
					local numer = r(sum)
					local denom = r(sum_w)
					post `ptablas' ("LAC") ("LAC") ("`wave'") ("`module'") ("`variable'") ("`ano'") ("`cut'") ("`sexo'") (`value') (`numer') (`denom') 	
							
							
						}
					}
			
			
			
			
			
			
			
			}	
		}
			


	
postclose `ptablas'
use `tablas', clear
save `tablas', replace 

	
cap export excel using "${results}/00.HFPS.xlsx", sh("TablesLM2", replace)  firstrow(var)


