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
              1: second wave 
==================================================*/

* 3.03 Edad
tab v03_03, m
cap g edad = v03_10c
*----------1.1: cuts 

cap g total = 1
* 3.03 Edad
tab v03_03, m



g sample     = inrange(v03_03,18,65)
g sample_pre = inrange(v03_03,20,67)


cap g age_18_24 = inrange(v03_03,18,24) 
label variable age_18_24 "Aged 18-24 years old"

cap g age_18_24_pre = inrange(v03_03,20,26) 
label variable age_18_24 "Aged 18-24 years old prepandemic"

cap g age_25_54 = inrange(v03_03,25,54)
label variable age_25_54 "Aged 25-54 years old"

cap g age_25_54_pre = inrange(v03_03,27,56)
label variable age_25_54 "Aged 25-54 years old prepandemic"

cap g age_55_65 = inrange(v03_03,55,65)
label variable age_55_65 "Aged 55-65 years old"

cap g age_55_65_pre = inrange(v03_03,57,67)
label variable age_55_65 "Aged 55-65 years old prepandemic"



* 3.04 Sexo

tab v03_04,m

g female = (v03_04==2)
g male   = (v03_04==1)

* marital status
*partnered
g estado_civil=v03_02 
replace estado_civil = u03_02 if _merge==3 // antes de la pandemia 

g partnered = inlist(estado_civil,2,3) if edad!=.
g unpartnered = inlist(estado_civil,1,4,5) if edad!=.

g partnered_f = female==1 & partnered ==1
g unpartnered_f = female==1 & unpartnered ==1

gen parent = (parent_0_5_hh==1) | (parent_0_12_hh==1)
gen no_parent = parent==0
gen mother_0_5 = (parent_0_5_hh==1) & (female==1)
label variable mother_0_5 "Mother of children 0-5years old"
* Presencia adultos mayores
gen		elder = 0 if v07_04 != .
replace elder = 1 if v07_04 > 0 & v07_04 !=.
lab val elder yn
lab var elder "HH with people 65+"

* nivel educativo  
*tab v03_09a, g(v309_)
** Nivel de educación del informante - 3 niveles (máximo alcanzado completo o incompleto)

cap lab drop v03_09a v03_10a
tab1 v03_09a v03_09b, m	

gen		primary = .
gen 	secondary = .
g 		terciary = .

// 501 Belice 
if `country'==501 {
	replace primary   = inlist(v03_09a, 50101,50102)
	replace secondary = v03_09a == 50103
	replace terciary  = inrange(v03_09a, 50104,50208)
}
// 502 Guatemala 
if `country'==502 {
	replace primary   = inlist(v03_09a, 50201,50202)
	replace secondary = inlist(v03_09a, 50203,50204) 
	replace terciary  = inrange(v03_09a, 50205,50207)
}	
// 503 El Salvador 
if `country'==503 {
	replace primary   = v03_09a == 50300
	replace primary   = v03_09a == 50301 & inrange(v03_09b,1,6) 
	replace secondary = v03_09a == 50301 & inrange(v03_09b,7,9)
	replace secondary = v03_09a == 50302
	replace terciary  = inrange(v03_09a, 50303,50305) 
}	
// 504 Honduras 
if `country'==504 {
	replace primary   = inlist(v03_09a, 50400,50401)
	replace secondary = inrange(v03_09a, 50402,50404) 
	replace terciary  = inrange(v03_09a, 50405,50407)
}
// 505 Nicaragua - CHECK VALUES OF v03_09a, v03_10a
if `country'==505 {
	replace primary   = inlist(v03_09a, 50500,50501)
	replace secondary = v03_09a == 50502
	replace terciary  = inrange(v03_09a, 50503,50505)
}	
// 506 Costa Rica
if `country'==506 {
	replace primary   = inlist(v03_09a, 50600,50601)
	replace secondary = inlist(v03_09a, 50602,50603) 
	replace terciary  = inrange(v03_09a, 50604,50606)
}
// 507 Panama
if `country'==507 {
	replace primary   = inlist(v03_09a, 50701,50702)
	replace secondary = inrange(v03_09a, 50703,50706) 
	replace terciary  = inlist(v03_09a, 50707,50708)
}
// 509 Haití 
if `country'==509 {
	replace primary   = inrange(v03_09a, 50901,50908)
	replace secondary = inrange(v03_09a, 50909,50915) 
	replace terciary  = v03_09a==50916
	
}
// 510 Perú
if `country'==510 {
	replace primary   = inlist(v03_09a, 51000,51001)
	replace secondary = v03_09a == 51002
	replace terciary  = inrange(v03_09a, 51003,51005)
}	
// 520 Mexico
if `country'==520 {
	replace primary   = inrange(v03_09a, 52001,52003)
	replace secondary = inlist(v03_09a, 52004,52005,52007,52008) 
	replace terciary  = inrange(v03_09a, 52009, 52013) | v03_09a == 52006 
}
// 540 Argentina 
if `country'==540 {
	replace primary   = inrange(v03_09a, 54001,54003)
	replace primary   = v03_09a == 54004 & inrange(v03_09b,1,7) 
	replace secondary = v03_09a == 54004 & inrange(v03_09b,8,9) 
	replace secondary = inlist(v03_09a, 54005,54006) 
	replace terciary  = inrange(v03_09a, 54007,54009) 
}
// 560 Chile
if `country'==560 {
	replace primary   = inrange(v03_09a, 56000,56006)
	replace secondary = inrange(v03_09a, 56007,56010)
	replace terciary  = inrange(v03_09a, 56011,56016)
}
// 570 Colombia
if `country'==570 {
	replace primary   = inrange(v03_09a, 57001,57003)
	replace secondary = inlist(v03_09a, 57004,57005) 
	replace terciary  = inlist(v03_09a, 57006,57007) 
}
// 591 Bolivia 
if `country'==591 {
	replace primary   = inlist(v03_09a, 59101,59102,59107)
	replace primary   = v03_09a == 59105 & inrange(v03_09b,1,6) 
	replace secondary = inlist(v03_09a, 59103,59104,59106,59108)
	replace secondary = v03_09a == 59105 & inrange(v03_09b,7,8) 
	replace terciary  = inrange(v03_09a, 59111,59116)	
}	
// 592 Guyana 
if `country'==592 {
	replace primary = inrange(v03_09a,59201,59203)
	replace secondary = v03_09a == 59204
	replace secondary = inrange(v03_09a, 59205,59208) 
}
// 593 Ecuador	 
if `country'==593 {
	replace primary   = inlist(v03_09a, 59301,59302)
	replace primary   = v03_09a == 59303 & inrange(v03_09b,1,7) 
	replace secondary = inlist(v03_09a, 59304,59305)
	replace secondary = v03_09a == 59303 & inrange(v03_09b,8,10)
	replace terciary  = inrange(v03_09a, 59306,59308)
}
// 595 Paraguay
if `country'==595 {
	replace primary   = inlist(v03_09a, 59501,59502,59503,59505)
	replace primary   = v03_09a == 59504 & inrange(v03_09b,1,6) 
	replace secondary = v03_09a == 59504 & inrange(v03_09b,7,9)
	replace secondary = v03_09a == 59506
	replace terciary  = inrange(v03_09a, 59507,59509)
}
// 598 Uruguay 
if `country'==598 {
	replace primary   = inlist(v03_09a, 59800,59801)
	replace secondary = inrange(v03_09a, 59802,59805)
	replace terciary  = inrange(v03_09a, 59806,59810)
}
if `country'==758 {
// 758 St Lucia
	replace primary   = inlist(v03_09a, 75801,75802)
	replace secondary = v03_09a == 75803
	replace terciary  = inrange(v03_09a, 75804,75807)
}
// 767 Dominica
if `country'==767 {
	replace primary   = inlist(v03_09a, 76701, 76702)
	replace secondary = v03_09a == 76703
	replace terciary  = inrange(v03_09a, 76704,76707)
}	
// 809 República Dominicana
if `country'==809 {
	replace primary   = inlist(v03_09a, 80901,80902,80909,80910)
	replace secondary = inlist(v03_09a, 80903,80904)
	replace terciary  = inrange(v03_09a, 80905,80908)
}	
// 876 Jamaica
if `country'==876 {
	replace primary   = inrange(v03_09a, 87601,87603)
	replace secondary = v03_09a == 87604
	replace terciary  = inrange(v03_09a, 87605,87608)
}
// 999 Brasil 
if `country'==999 {
	replace primary   = inrange(v03_09a, 99901,99903)
	replace secondary = inlist(v03_09a, 99904,99905) 
	replace terciary  = inlist(v03_09a, 99906,99907) 
}

** Nivel de educación jefe de hogar (máximo alcanzado completo o incompleto)

// Completamos variables para todos los jefes de hogar. 
clonevar v03_10a_ = v03_10a 
replace v03_10a_ = v03_09a if v03_10a == . & v03_01 == 1
clonevar v03_10b_ = v03_10b 
replace v03_10b_ = v03_09b if v03_10b == . & v03_01 == 1

gen	primary_hh = .
gen secondary_hh = .
gen terciary_hh =.

// 501 Belice - 26 NS/NR (5.8%)
if `country'==501 {
	replace primary_hh   = inlist(v03_10a_, 50101,50102)
	replace secondary_hh = v03_10a_ == 50103
	replace terciary_hh  = inrange(v03_10a_, 50104,50208)
}	
// 502 Guatemala - 24 NS/NR (3.23%)
if `country'==502 {
	replace primary_hh   = inlist(v03_10a_, 50201,50202)
	replace secondary_hh = inlist(v03_10a_, 50203,50204) 
	replace terciary_hh  = inrange(v03_10a_, 50205,50207)
}
if `country'==503 {	
// 503 El Salvador - 
	replace primary_hh   = v03_10a_ == 50300
	replace primary_hh   = v03_10a_ == 50301 & inrange(v03_10b_,1,6) 
	replace secondary_hh = v03_10a_ == 50301 & inrange(v03_10b_,7,9)
	replace secondary_hh = v03_10a_ == 50302
	replace terciary_hh  = inrange(v03_10a_, 50303,50305)
}
if `country'==504 {	
// 504 Honduras - 
	replace primary_hh   = inlist(v03_10a_, 50400,50401)
	replace secondary_hh = inrange(v03_10a_, 50402,50404) 
	replace terciary_hh  = inrange(v03_10a_, 50405,50407)
}
// 505 Nicaragua -
if `country'==505 {
	replace primary_hh   = inlist(v03_10a_, 50500,50501)
	replace secondary_hh = v03_10a_== 50502
	replace terciary_hh  = inrange(v03_10a_, 50503,50505) 
}	
// 506 Costa Rica -
if `country'==506 {
	replace primary_hh = inlist(v03_10a_, 50600,50601)
	replace secondary_hh = inlist(v03_10a_, 50602,50603) 
	replace terciary_hh = inrange(v03_10a_, 50604,50606)
}	
// 507 Panama - 29 NS/NR (6.07%)
if `country'==507 {
	replace primary_hh   = inlist(v03_10a_, 50701,50702)
	replace secondary_hh = inrange(v03_10a_, 50703,50706) 
	replace terciary_hh  = inlist(v03_10a_, 50707,50708)
}	
// 509 Haití 
if `country'==509 {
	replace primary_hh   = inrange(v03_10a_, 50901,50908)
	replace secondary_hh = inrange(v03_10a_, 50909,50915) 
	replace terciary_hh  = v03_10a_==50916
}
// 510 Perú
if `country'==510 {
	replace primary_hh   = inlist(v03_10a_, 51000,51001)
	replace secondary_hh = v03_10a_ == 51002
	replace terciary_hh  = inrange(v03_10a_, 51003,51005)
}		
// 520 Mexico - 47 NS/NR (3.16%)
if `country'==520 {
	replace primary_hh   = inrange(v03_10a_, 52001,52003)
	replace secondary_hh = inlist(v03_10a_, 52004,52005,52007,52008) 
	replace terciary_hh  = inrange(v03_10a_, 52009, 52013) | v03_10a_ == 52006 
}	
// 540 Argentina - 21 NS/NR (3.85%)
if `country'==540 {
	replace primary_hh   = inrange(v03_10a_, 54001,54003)
	replace primary_hh   = v03_10a_== 54004 & inrange(v03_10b_,1,7) 
	replace secondary_hh = v03_10a_ == 54004 & inrange(v03_10b_,8,9) 
	replace secondary_hh = inlist(v03_10a_, 54005,54006) 
	replace terciary_hh  = inrange(v03_10a_, 54007,54009) 
}
// 560 Chile -
if `country'==560 {
	replace primary_hh   = inrange(v03_10a_, 56000,56006)
	replace secondary_hh = inrange(v03_10a_, 56007,56010)
	replace terciary_hh  = inrange(v03_10a_, 56011,56016)
}	
// 570 Colombia - 
if `country'==570 {
	replace primary_hh   = inrange(v03_10a_, 57001,57003)
	replace secondary_hh = inlist(v03_10a_, 57004,57005) 
	replace terciary_hh  = inlist(v03_10a_, 57006,57007) 
}	
// 591 Bolivia - 26 NS/NR (3.72%)
if `country'==591 {
	replace primary_hh   = inlist(v03_10a_, 59101,59102,59107)
	replace primary_hh   = v03_10a_== 59105 & inrange(v03_10b_,1,6) 
	replace primary_hh   = inlist(v03_10a_, 59109,59110) 	// Equivalente a P1W1
	replace secondary_hh = inlist(v03_10a_, 59103,59104,59106,59108)
	replace secondary_hh = v03_10a_== 59105 & inrange(v03_10b_,7,8) 
	replace terciary_hh  = inrange(v03_10a_, 59111,59116)
}	
// 592 Guyana - 44 NS/NR (9.32%)
if `country'==592 {
	replace primary_hh   = inrange(v03_10a_,59201,59203)
	replace secondary_hh = v03_10a_ == 59204
	replace terciary_hh  = inrange(v03_10a_, 59205,59208) 
}
// 593 Ecuador - 29 NS/NR (4.12%)
if `country'==593 {
	replace primary_hh   = inlist(v03_10a_, 59301, 59302)
	replace primary_hh   = v03_10a_ == 59303 & inrange(v03_10b_,1,7) 
	replace secondary_hh = inlist(v03_10a_, 59304,59305)
	replace secondary_hh = v03_10a_ == 59303 & inrange(v03_10b_,8,10)
	replace terciary_hh  = inrange(v03_10a_, 59306,59308)
}
// 595 Paraguay - 48 NS/NR (8.36%)
if `country'==595 {
	replace primary_hh   = inlist(v03_10a_, 59501,59502,59503,59505)
	replace primary_hh   = v03_10a_ == 59504 & inrange(v03_10b_,1,6) 
	replace secondary_hh = v03_10a_ == 59504 & inrange(v03_10b_,7,9)
	replace secondary_hh = v03_10a_ == 59506
	replace terciary_hh  = inrange(v03_10a_, 59507,59509)
}	
// 598 Uruguay - 
if `country'==598 {
	replace primary_hh   = inlist(v03_10a_, 59800,59801)
	replace secondary_hh = inrange(v03_10a_, 59802,59805)
	replace terciary_hh  = inrange(v03_10a_, 59806,59810)

}	
if `country'==758 {
// 758 St Lucia - 64 NS/NR (15.46%)
	replace primary_hh   = inlist(v03_10a_, 75801,75802)
	replace secondary_hh = v03_10a_ == 75803
	replace terciary_hh  = inrange(v03_10a_, 75804,75807)

}	
if `country'==767 {
// 767 Dominica - 95 NS/NR (21.84%)
	replace primary_hh   = inlist(v03_10a_, 76701, 76702)
	replace secondary_hh = v03_10a_ == 76703
	replace terciary_hh  = inrange(v03_10a_, 76704,76707)
	
}	
// 809 República Dominicana -
if `country'==809 {
	replace primary_hh   = inlist(v03_10a_, 80901,80902,80909,80910)
	replace secondary_hh = inlist(v03_10a_, 80903,80904)
	replace terciary_hh  = inrange(v03_10a_, 80905,80908)

}
if `country'==876 {	
// 876 Jamaica - 84 NS/NR (19.72%)
	replace primary_hh = inrange(v03_10a_, 87601,87603)
	replace secondary_hh = v03_10a_ == 87604
	replace terciary_hh = inrange(v03_10a_, 87605,87608)
} 
 


 
* Area 
tab v03_08a, m
g urban = (v03_08a==1)
g rural = (v03_08a==2)



*-------------------------------Modules 

*----------2.2: Labor Market 


/* Resumen variables de interes para resultados
ocupado1
desocupado1
ocu_pea1
trabajo remoto

*/

// Correccion no responde y valores fuera de rango a missing
recode v05_03 v05_04 v05_10 v05_11 v05_17 v05_18 v05_19 v05_20 v05_24 (-98 -99 98 99=.)
recode v05_11 (28=.)	// R Dom 1 caso que puede haber sido 98
recode v05_13 (24=.)	// 4 Paises, 8 casos con valor fuera de rango
recode v05_18 (4=.)		// Col 1 caso con valor fuera de rango
recode v05_25 (20=.)	// Nic 1 caso con valor fuera de rango
recode v05_27 (21 23 =.)	// 9 paises 28 casos tienen 21 que no es permitido


// Corregimos horas mayores al límite superior de 140
	sum  v05_03 v05_04 v05_20 v05_24 
	foreach v of varlist v05_03 v05_20 v05_24 {
	replace `v' = 140 if `v' > 140 & `v' != .	    
	}


// Completar variables W2 para muestra panel excepto variable de tipo empleo porque son categorías diferentes

foreach x of numlist 16/20 22/24 26 27/28 {
    clonevar v05_`x'_ = v05_`x' 
	replace  v05_`x'_ = u05_`x' if v05_`x' == . & tipo_muestra == 2
	}
	

* Empleo actual comparable PNUD
gen ocupado1 = cond(v05_01 == 1 | inlist(v05_13,2,5,6,16,19,21),1,0)
replace ocupado1 = . if v05_01==.
lab var ocupado1 "Ocupado actual definicion 2021"
lab val ocupado1 yn

* Trabajo actual desagregado def 2021
gen 	trabajo1 = 3
replace trabajo1 = 1 if v05_01 == 1
replace trabajo1 = 2 if v05_01 == 2 & inlist(v05_06,1,3) & inlist(v05_13,2,5,6,16,19,21)
lab def trab 1 "Si trabajó" 2 "Ausente temporal" 3 "No trabajó", modify
lab val trabajo1 trab
lab var trabajo1 "Descomposición trabajo 2021"

* Desocupado actual 
gen		desocupado1 = cond(ocupado1== 0 & v05_12 == 1 & v05_15 == 1,1,0)
replace desocupado1 = 1 if ocupado1 == 0 & v05_12 == 1 & v05_06 != 2
replace desocupado1 = . if ocupado1==.
lab val desocupado1 yn

* Población en la fuerza laboral actual
gen		activo1 = (ocupado1 == 1 | desocupado1 == 1)
replace activo1 = . if ocupado1 ==.
lab val activo1 yn


* Fuera de la fuerza laboral actual
gen		inactivo1 = 0
replace inactivo1 = 1 if ocupado1 == 0 & v05_12 == 2 & v05_15 == 2 // no busca y no está disponible
replace inactivo1 = 1 if ocupado1 == 0 & v05_12 == 1 & v05_15 == 2 // busca pero no disponible
replace inactivo1 = 1 if ocupado1 == 0 & v05_12 == 2 & v05_15 == 1 // no busca y disponible
replace inactivo1 = 1 if ocupado1 == 0 & v05_12 == 2
replace inactivo1 = . if ocupado1 ==.
lab val inactivo1 yn



* Condicion de actividad actual
gen 	condact1 = 1 if ocupado1 == 1
replace condact1 = 2 if desocupado1 == 1
replace condact1 = 3 if inactivo1 == 1
lab def condact	1 "Ocupado" 2 "Desocupado" 3 "Inactivo"
lab val condact1 condact
lab var condact1 "Condicion actividad actual"

* Tasa empleo / población activa actual
gen 	ocu_pea1 = 0 if ocupado1 == 0 & activo1 == 1 
replace ocu_pea1 = 1 if ocupado1 == 1 & activo1 == 1 
lab def ocu_pea 0 "desocupado" 1 "ocupado"
lab val ocu_pea1 ocu_pea

* Dummy trabajo remoto
gen		trabajo_remoto = .
replace trabajo_remoto = 1 if v05_04 >= 1 & v05_04 != .
replace trabajo_remoto = 0 if v05_04 == 0
replace trabajo_remoto = . if ocupado1 != 1
label define trabajo_remoto 0 "No trabajó de manera remota" 1 "Trabajó de manera remota"
label val trabajo_remoto trabajo_remoto
label var trabajo_remoto "¿Trabajó al menos una hora durante la semana pasada de manera remota o virtual?"

* Empleo formal actual
gen		formal1 = v05_08 == 1 if ocupado1==1
lab val formal1 yn
 
* Condición de actividad actual con informalidad
gen condact1v2 = condact1
replace condact1v2 = 0 if condact1 == 1 & formal1 == 1
lab var condact1 "Condicion actividad actual con informalidad"
label define condactv2 0 "Ocupados formales" 1 "Ocupados informales" 2 "Desocupados" 3 "Inactivos"
label val condact1v2 condactv2

* Horas de trabajo
gen		horas1 = v05_03 if ocupado1 == 1
lab var horas1 "Horas de trabajo semana actual"

gen		hremo1 = v05_04 if ocupado1 == 1 
lab var hremo1 "Horas trabajo remoto semana actual"

gen		workhome = v05_04 / v05_03 if (v05_03 > 0 & v05_03 != .) & ocupado1 == 1
replace workhome = 1 if (workhome > 1 & workhome != .) & ocupado1 == 1
lab var workhome "Proporcion horas de trabajo remoto"


*--- SITUACIÓN PREPANDEMIA ---*

* Ocupación pre pandemia 
gen 	ocupado0 = v05_16_==1 
replace ocupado0 =. if v05_16_==. & v01_09==.	// dejamos como missing?
lab var	ocupado0 "Ocupado pre-pandemia"
lab val ocupado0 yn

* Desocupación pre pandemia // Si en razón de no trabajo menciona que estaba buscando
gen desocupado0 = ocupado0 == 0 & v05_28_ == 8
replace desocupado0 =. if v05_16_==.	// dejamos como missing?
lab var desocupado0 "Desocupado pre-pandemia"
lab val desocupado0 yn

* Población en la fuerza laboral pre pandemia
gen activo0 = (ocupado0 == 1 | desocupado0 == 1)
replace activo0 =. if v05_16_==.
lab val activo0 yn

* Población fuera de la fuerza laboral pre pandemia (inactividad) 
gen inactivo0 = ocupado0 == 0 & desocupado0 ==0
replace inactivo0 =. if v05_16_==.	// dejamos como missing?
lab var inactivo0 "Inactivo pre-pandemia"
lab val inactivo0 yn



* Condicion de actividad pre pandemia
gen condact0 = 1 if ocupado0 == 1
replace condact0 = 2 if desocupado0 == 1
replace condact0 = 3 if inactivo0 == 1
lab val condact0 condact
lab var condact0 "Condicion actividad pre-pandemia"

* Tasa empleo / población activa pre pandemia
gen 	ocu_pea0 = 0 if ocupado0 == 0 & activo0 == 1 
replace ocu_pea0 = 1 if ocupado0 == 1 & activo0 == 1 
lab val ocu_pea0 ocu_pea

* Empleo formal pre pandemia
gen formal0 = v05_18_ == 1 if ocupado0 == 1 
replace formal0 = 1 if v05_22_ == 1 & ocupado0 == 1
replace formal0 = . if v05_18_==. & v05_22_==.	// dejar como missing?
lab val formal0 yn

* Condición de actividad pre pandemia con informalidad
gen condact0v2 = condact0
replace condact0v2 = 0 if condact0 == 1 & formal0 == 1
lab var condact0v2 "Condicion actividad pre-pandemia con informalidad"
label val condact0v2 condactv2

* Horas de trabajo pre pandemia (completa)
clonevar horas0 = v05_20_ if ocupado0 == 1
replace  horas0 = v05_24_ if ocupado0 == 1 & horas0 == .
replace  horas0 = . if v05_20_==. & v05_24_==. // dejar como missing?

* Rama actividad pre pandemia (completa)
clonevar rama0 = v05_26_ if ocupado0 == 1
replace  rama0 = v05_11 if ocupado0 == 1 & rama0 == .
replace  rama0 = u05_11 if ocupado0 == 1 & rama0 == . & tipo_muestra == 2

// Completamos variable de w2 para muestra no panel
*clonevar v05_25_ = v05_25 if ocupado0 == 1
*replace  v05_25_ = v05_09 if ocupado0 == 1 & v05_25_ == .


*--- VARIABLES DE TRANSICIONES LABORALES ---*
// Matrices se realizan con do file de UNDP 

gen ocupado1_e 	  = ocupado1 	if sample==1
gen formal1_e 	  = formal1 	if sample==1
gen horas1_e 	  = horas1 		if sample==1
gen desocupado1_e = desocupado1 if sample==1
gen activo1_e     = activo1 	if sample==1
gen inactivo1_e	  = inactivo1 	if sample==1

gen ocupado0_e 	  = ocupado0 	if sample_pre==1
gen formal0_e 	  = formal0 	if sample_pre==1
gen horas0_e 	  = horas0 		if sample_pre==1
gen desocupado0_e = desocupado0 if sample_pre==1
gen activo0_e 	  = activo0 	if sample_pre==1
gen inactivo0_e	  = inactivo0 	if sample_pre==1

gen ocupado0_e_18 = ocupado0_e if  age_18_24_pre ==1

* Perdida empleo actual vs pre pandemia (comparable HFPS 2020)
gen		perdida01 = .
replace perdida01 = 0 if ocupado0 == 1 
replace perdida01 = 1 if ocupado0 == 1 & ocupado1 == 0
lab var perdida01 "Perdida empleo pre pandemia resp. ocupados pre pandemia"

gen		perdida01_e = .
replace perdida01_e = 0 if ocupado0_e == 1 
replace perdida01_e = 1 if ocupado0_e == 1 & ocupado1_e == 0
lab var perdida01_e "Perdida empleo pre pandemia resp. ocupados pre pandemia"

* Ganancia empleo actual vs pre pandemia
gen ganancia01_e = . 
replace ganancia01_e = 1 if ocupado0_e == 0 & ocupado1_e == 1
replace ganancia01_e = 0 if ocupado0_e == 0 & ocupado1_e == 0
replace ganancia01_e = 0 if perdida01_e == 1
la var ganancia01_e "Ganancia empleo pre pandemia resp. ocupados pre pandemia"


gen ganancia01 = . 
replace ganancia01 = 1 if ocupado0 == 0 & ocupado1 == 1
replace ganancia01 = 0 if ocupado0 == 0 & ocupado1 == 0
replace ganancia01 = 0 if perdida01 == 1
la var ganancia01 "Ganancia empleo pre pandemia resp. ocupados pre pandemia"


gen		ocu0_desoc1 = .
replace ocu0_desoc1 = 0 if ocupado0 == 1 
replace ocu0_desoc1 = 1 if ocupado0 == 1 & desocupado1 == 1
lab var ocu0_desoc1 "Del empleo al desempleo"

gen		ocu0_inac1 = .
replace ocu0_inac1 = 0 if ocupado0 == 1 
replace ocu0_inac1 = 1 if ocupado0 == 1 & inactivo1 == 1
lab var ocu0_inac1 "Del empleo a inactividad"
lab val perdida01 ocu0_desoc1 ocu0_inac1 yn

gen inac0_ocu1=. 
replace inac0_ocu1 = 0 if inactivo0 == 1 
replace inac0_ocu1 = 1 if (inactivo0 == 1 & ocupado1 == 1)
la var inac0_ocu1 "Ganancia de empleo de inactivo a ocupado"

gen desoc0_ocu1=.
replace desoc0_ocu1 = 0 if desocupado0 == 1
replace desoc0_ocu1 = 1 if (desocupado0 == 1 & ocupado1 == 1)
la var desoc0_ocu1 "Ganancia de empleo de desocupado a ocupado"


* Transición de ocupado formal a informal - ratio respecto a formales pre pandemia
gen		for0_inf1 = 0 if (ocupado0==1 & ocupado1==1) & formal0==1 
replace for0_inf1 = 1 if (formal0==1 & formal1==0) & ocupado0==1 & ocupado1==1
lab var for0_inf1 "Ocupados formales que pasaron a informalidad"


* Transición de inactivo a activo
gen inac0_ac1 = .
replace inac0_ac1 = 1 if condact0 == 3 & inlist(condact1,1,2)
replace inac0_ac1 = 0 if condact0 == 3 & inlist(condact1,3)
label var inac0_ac1 "Inactivos que pasaron a activos"

* Transición de inactivo a formal
gen inac0_formal1 = .
replace inac0_formal1 = 1 if condact1v2 == 0 & condact0 == 3
replace inac0_formal1 = 0 if condact0 == 3 & inlist(condact1v2,1,2,3)
label var inac0_formal1 "Inactivos que pasaron a ocupados formales"

* Transición de inactivo a informal
gen inac0_informal1 = .
replace inac0_informal1 = 1 if condact1v2 == 1 & condact0 == 3
replace inac0_informal1 = 0 if condact0 == 3 & inlist(condact1v2,0,2,3)
label var inac0_informal1 "Inactivos que pasaron a ocupados informales"

* Transición de inactivo a desocupado
gen inac0_unemp1 = .
replace inac0_unemp1 = 1 if condact1v2 == 2 & condact0 == 3
replace inac0_unemp1 = 0 if condact0 == 3 & inlist(condact1v2,1,0,3)
label var inac0_unemp1 "Inactivos que pasaron a desempleados"


* Activo
gen act0_formal1=.
replace act0_formal1 = 0 if activo0 == 1 
replace act0_formal1 = 1 if (activo0 == 1 & ocupado1 == 1 & formal1 == 1)

gen act0_informal1=.
replace act0_informal1 = 0 if activo0 == 1 
replace act0_informal1 = 1 if (activo0 == 1 & ocupado1 == 1 & formal1 == 0)

gen act0_desocupado1=. 
replace act0_desocupado1 = 0 if activo0 == 1 
replace act0_desocupado1 = 1 if (activo0 == 1 & desocupado1 == 1)

gen act0_inac1=.
replace act0_inac1 = 0 if activo0 == 1 
replace act0_inac1 = 1 if (activo0 == 1 & activo1 == 0)

*----------2.3.1: Income

local module income 

* Percentage of households who report a reduction of income since beginning of 2021:
gen income_red = 0 if v06_17a != 98
replace income_red = 1 if (v06_17a==3)
label variable income_red "Beginning of 2021"

* income increase

gen income_incr = 0 if v06_17 != 98
replace income_incr = 1 if (v06_17a==1)
label variable income_red "Beginning of 2021"

* stay the same
gen income_same = 0 if v06_17 != 98
replace income_same = 1 if (v06_17a==2)
label variable income_same "Beginning of 2021"

* not better off
gen income_not_better = 0 if v06_17a != 98
replace income_not_better = 1 if inlist(v06_17a,2,3)
label variable income_not_better "Beginning of 2021"

**** before the pandemic 
gen income_red_bp = 0 if  u06_17 != .
replace income_red_bp = 1 if (u06_17==3)
label variable income_red_bp "Before the pandemic"

gen income_same_bp = 0 if   u06_17 != .
replace income_same_bp = 1 if (u06_17==2)
label variable income_same_bp "Before the pandemic"

gen income_incr_bp = 0 if   u06_17 != .
replace income_incr_bp = 1 if (u06_17==1)
label variable income_red "Beginning of 2021"

* reduced to.... in 2021
g income_red_to_red = 0 if income_red_bp==1
replace income_red_to_red = 1 if income_red_bp==1 & income_red==1

g income_red_to_same = 0 if income_red_bp==1
replace income_red_to_same = 1 if income_red_bp==1 & income_same==1

g income_red_to_incr = 0 if income_red_bp==1
replace income_red_to_incr = 1 if income_red_bp==1 & income_incr==1

* same to ....in 2021

g income_same_to_red = 0 if income_same_bp==1
replace income_same_to_red = 1 if income_same_bp==1 & income_red==1

g income_same_to_same = 0 if income_same_bp==1
replace income_same_to_same = 1 if income_same_bp==1 & income_same==1

g income_same_to_incr = 0 if income_same_bp==1
replace income_same_to_incr = 1 if income_same_bp==1 & income_incr==1


* increase prepand to ....in 2021

g income_incr_to_red = 0 if income_incr_bp==1
replace income_incr_to_red = 1 if income_incr_bp==1 & income_red==1

g income_incr_to_same = 0 if income_incr_bp==1
replace income_incr_to_same = 1 if income_incr_bp==1 & income_same==1

g income_incr_to_incr = 0 if income_incr_bp==1
replace income_incr_to_incr = 1 if income_incr_bp==1 & income_incr==1

g reconnected = income_red_to_red !=. | income_red_to_same!=. | income_red_to_incr!=.

* Percentage of households who received emergency government transfers 
g income_eme_gov_pand = .
replace income_eme_gov_pand= 1 if (v06_06a==1)
replace income_eme_gov_pand= 0 if (v06_06a==2)

* Percentage point change of households that received regular government transfers 
* before the pandemic
tab v06_03, m
g income_reg_gov_prepand = .
replace income_reg_gov_prepand = 1 if (v06_03==1)
replace income_reg_gov_prepand = 0 if (v06_03==2)

* during the pandemic 
g income_reg_gov_pand = .
replace income_reg_gov_pand = 1 if (v06_03a==1)
replace income_reg_gov_pand = 0 if (v06_03a==2)

*----------2.3.2: Financial stress

* Percentage of household that since 2021 to cover essential expenses (food, health or education) have been forced to:
*Use savings 
g fs_savings = (v14_01a==1)
*Stop paying rent/mortgage or financial obligations
g fs_rent_obligations = (v14_01b==1)
*Insert a new HH member to the labor force
g fs_new_labor = (v14_02a==1)
*Insert a HH member under 18 to the labor force 
g fs_child_labor = (v14_02b==1)
* 
* 14.7 aumentos percepcion inseguridad y violencia.
foreach x in v14_05 v14_06{
    gen aumento_`x' =. 
	replace aumento_`x' = 0 if inlist(`x', 2,3)
	replace aumento_`x' = 1 if `x' == 1
}

* propuesta: percepcion de violencia e inseguridad en el entorno - compuesta 
gen percep_inseg_violencia = . 
replace percep_inseg_violencia = 0 if aumento_v14_05 == 0 & aumento_v14_06 == 0 
replace percep_inseg_violencia = 1 if aumento_v14_05 == 1 | aumento_v14_06 == 1 


* violencia  
g percep_violencia = . 
replace percep_violencia = aumento_v14_06 

g percep_inseguridad = . 
replace percep_violencia = aumento_v14_05 



*----------2.4: Food insecurity 
g run_out_food = (v04_01==1)

// Completar variable v04_04
clonevar v04_04_ = v04_04 
replace  v04_04_ = u04_04 if v04_04 == . & tipo_muestra == 2
tab pais v04_04_, m

g run_out_food_pre_pan = (v04_04_==1)

*----------2.5: Education

* Corregir observaciones que no siguen CATI

foreach var in v08_09a v08_09b v08_09c v08_09d v08_09e v08_09f v08_09z{
	replace `var' = . if v08_08 == 2
}

gen chil_06_17 =(w_cha_ph2w2 != .) if inrange(v07_19,6,17)
gen chil_01_05 =(w_cha_ph2w2 != .) if inrange(v08_16,1,5)
* Share of school-age children attending some form of education activities (in person or remotely)
* Change in school attendance
* before the pandemic

gen attendance_prepan_6_17 = cond(inlist(v08_02,1,2),1,0)
replace attendance_prepan_6_17 = . if v08_02 == 98 | v08_02 == . 
replace attendance_prepan_6_17 = . if v08_02 == 3 & v07_19 == 6



replace attendance_prepan_6_17 = . if v08_02 == 98 | v08_02 == . 
replace attendance_prepan_6_17 = . if v08_02 == 3 & v07_19 == 6

*g attendance_6_17 = v08_03==1 & ((v08_05==1 | v08_05==2 & v08_06==1) | (v08_08==1 | v08_08==2 & v08_10==1))
gen attendance_6_17 = . 
replace attendance_6_17 = 0 if v08_02 != .
replace attendance_6_17 = 1 if v08_05 == 1
replace attendance_6_17 = 1 if v08_08 == 1
replace attendance_6_17 = 1 if inlist(v08_06,1,17)
replace attendance_6_17 = 1 if inlist(v08_10,1,2,15)
replace attendance_6_17 = . if v08_05 == 98 & v08_08 == 98
* schools offer face to face classes 
* schools offer face to face classes 
gen oferta_presencial1 = 0 if attendance_6_17 == 1
replace oferta_presencial1 = 1 if v08_04 == 1
replace oferta_presencial1 = . if attendance_6_17 != 1

*8.7.2 Asistencia presencial
gen face_to_face_classes_6_17 = 0 if attendance_6_17 == 1
replace face_to_face_classes_6_17 = 1 if v08_05 == 1
replace face_to_face_classes_6_17 = 1 if v08_10 == 15 
replace face_to_face_classes_6_17 = . if attendance_6_17 != 1

* 8.13.1 Asistia a un centro antes de la pandemia
gen attendance_prepan_1_5 = 1 if v08_17 == 1
replace attendance_prepan_1_5 = 0 if v08_17 == 2

* 8.14.1 Asiste a un centro ahora
gen attendance_1_5 = 1 if v08_19 == 1
replace attendance_1_5 = 0 if v08_19 == 2



*Perception of children learning in relation to before the pandemic 
* 8.12.1 Aprenden menos o mucho menos
gen learning_less = 1 if inlist(v08_12,1,2)
replace learning_less = 0 if inlist(v08_12,3,4,5)
label var learning_less "Indicador de niños matriculados antes y ahora que consideran que ahora aprenden menos" 
label val learning_less yn 

* 8.12.2 Aprenden igual
gen learning_same = 1 if inlist(v08_12,3)
replace learning_same = 0 if inlist(v08_12,1,2,4,5)
label var learning_same "Indicador de niños matriculados antes y ahora que consideran que ahora igual" 
label val learning_same yn 




* 8.4.1 Porcentaje de matriculados en colegio público

	gen publico1 = .

	// Países con solo sistema público o privado
	foreach pais in 501 502 503 504 505 507 510 520 580 592 598 758 876{
		replace publico1 = 1 if v08_03b == `pais'01
		replace publico1 = 0 if v08_03b == `pais'02
	}

	// Países con sistema público, privado y mixto
	foreach pais in 506 509 540 591 595 809{
		replace publico1 = 1 if v08_03b == `pais'01
		replace publico1 = 0 if inlist(v08_03b,`pais'02,`pais'03)
	}
	
	// Chile
	replace publico1 = 1 if inlist(v08_03b,56001,56005)
	replace publico1 = 0 if inlist(v08_03b,56002,56003,56004)
	
	// Ecuador
	replace publico1 = 1 if inlist(v08_03b,59301,59304)
	replace publico1 = 0 if inlist(v08_03b,59302,59303)

* 8.4.2 Porcentaje de matriculados en colegio privado

	gen privado1 = .

	// Países con solo sistema público o privado
	foreach pais in 501 502 503 504 505 507 510 520 580 592 598 758 876{
		replace privado1 = 1 if v08_03b == `pais'02
		replace privado1 = 0 if v08_03b == `pais'01
	}
	
	// Países con sistema público, privado y mixto
	foreach pais in 506 509 591 595 809{
		replace privado1 = 1 if v08_03b == `pais'02
		replace privado1 = 0 if inlist(v08_03b,`pais'01,`pais'03)
	}
	
	// Argentina: se incluye la educación parroquial como privada
	replace privado1 = 1 if inlist(v08_03b,54002,54003)
	replace privado1 = 0 if v08_03b == 54001

	// Chile
	replace privado1 = 1 if inlist(v08_03b,56003)
	replace privado1 = 0 if inlist(v08_03b,56001,56002,56004,56005)
	
	// Ecuador
	replace privado1 = 1 if inlist(v08_03b,59303)
	replace privado1 = 0 if inlist(v08_03b,59301,59302,59304)
	
* 8.4.3 Porcentaje de matriculados en colegio mixto

	gen mixto1 = .

	// Países con solo sistema público o privado
	foreach pais in 501 502 503 504 505 507 510 520 580 592 598 758 876{
		replace mixto1 = 0 if inlist(v08_03b,`pais'01,`pais'02)
	}
	
	// Países con sistema público, privado y mixto
	* Costa Rica (subvencionado = institución privada que recibe dinero del Estado)
	* Haiti: CONFIRMAR QUÉ SIGNIFICA OPCION 50903
	* Bolivia (convenio = financiado por el estado administrado por la Iglesia)
	* Paraguay (subvencionado = administrado por privado financiado por el Estado)
	* Rep Dom: (semioficial)
	
	foreach pais in 506 509 591 595 809{
		replace mixto1 = 1 if v08_03b == `pais'03
		replace mixto1 = 0 if inlist(v08_03b,`pais'01,`pais'02)
	}
	
	//Argentina (tiene 3 sistemas pero ninguno es mixto)
	replace mixto1 = 0 if inlist(v08_03b,54001,54002,54003)
	
	// Chile: (particular subvencionado = financiado por el estado y por los padres; de administración delegada = propiedad del Estado financiados por privados)
	replace mixto1 = 1 if inlist(v08_03b,56002,56004)
	replace mixto1 = 0 if inlist(v08_03b,56001,56003,56005)
	
	// Ecuador: (fiscomisional = administrados por privados financiados por el Estado)
	replace mixto1 = 1 if inlist(v08_03b,59302)
	replace mixto1 = 0 if inlist(v08_03b,59301,59303,59304)

	cap g run_out_food = (v04_01==1)
cap g run_out_food_pre_pan = (v04_04==1)
	
*----------2.6: Gender

gen lost =. 
replace lost = perdida01
la var lost "Job loss in the pandemic"

foreach v in v09_11 v09_12 v09_13 {
	gen aumento_`v' = 1 if inlist(`v',1)
	replace aumento_`v' = 0 if inlist(`v',2,3,4)
	label var aumento_`v' "Indicador de aumento en el tiempo dedicado a la actividad"
	label val aumento_`v' yn
}

egen aumento_domestica = rowmax(aumento*)
label var aumento_domestica "Indicador de aumento en el tiempo dedicado a alguna tarea doméstica o de cuidado"

* 9.5 Toma de decisiones antes de la pandemia (se debe mostrar para hombres y para mujeres)

gen toma_dec_gasto0 = 1 if v09_08a == 1
replace toma_dec_gasto0 = 0 if inlist(v09_08a,2,3,4)
label var toma_dec_gasto0 "Indicador de si es la persona que principalmente tomaba las decisiones de gasto antes de la pandemia"
label val toma_dec_gasto0 yn

* 9.6 Toma de decisiones actualmente (se debe mostrar para hombres y para mujeres)

gen toma_dec_gasto1 = 1 if v09_08b == 1
replace toma_dec_gasto1 = 0 if inlist(v09_08b,2,3,4)
label var toma_dec_gasto1 "Indicador de si es la persona que principalmente toma las decisiones de gasto actualmente"
label val toma_dec_gasto1 yn


gen aumento_dom =.
replace aumento_dom = 0 if inlist(v09_11,2,3,4)
replace aumento_dom = 1 if v09_11 == 1

gen aumento_childcare =. 
replace aumento_childcare = 0 if inlist(v09_12,2,3,4)
replace aumento_childcare = 1 if v09_12 == 1

gen aumento_acomp =. 
replace aumento_acomp = 0 if inlist(v09_13,2,3,4)
replace aumento_acomp = 1 if v09_13 == 1


*----------2.7: Health

* hea1. Proporción de hogares en los que algún miembro necesitó un servicio de salud 
* Numerador: Todos los hogares en los que al menos un miembro necesitó un servicio de salud
* Denominador: Todos los hogares
gen hea1 = .
replace hea1 = 1 if v02_02==1
replace hea1 = 0 if v02_02==2
replace hea1 = . if v02_02==98
la var hea1 "Proportion of hhs at least one member who needed health services"

*hea2. Proporción de hogares en los que algún miembro no pudo acceder a un servicio de salud cuando lo necesitó
*Numerador: Todos los hogares en los que al menos algún miembro no puedo acceder a un servicio de salud cuando lo necesitó
*Denominador: Todos los hogares en los que al menos algún miembro necesitó un servicio de salud 

gen hea2 = 0 if hea1 == 1
foreach x in a b c d e f g h i j k l m z {
	recode v02_03`x' (0=2) 
}
foreach x in a b c d e f g h i j k l m z {
	replace hea2 = 1 if hea1 == 1 & v02_03`x'== 1 & v02_04`x'== 3
}

la var hea2 "Proportion of hhs could not access health services when needed"


*hea3. Vacunación - estatus
gen hea3 = 1 if v02_09 == 1
replace hea3 = 2 if v02_10 == 1
replace hea3 = 3 if inlist(v02_10,2,3)
la def hea3 1 "Vacunado" 2 "No vacunado, planea vacunarse" 3 "No vacunado, no planea vacunarse"
la val hea3 hea3
la var hea3 "Estatus de vacunación"

gen heal3=. 
replace heal3 = 1 if hea3 == 1
replace heal3 = 0 if (hea3 !=1 & hea3 !=.)
la var heal3 "Vacunados"

*hea4. Vaccination reluctancy - CAMBIAR DE NOMBRE PARA NO CONFUNDIR CON EL INDICADOR DEL TWO-PAGER
* numerator: all hhs where respondent has not received the vaccine yet and is not planing to receive the vaccine
* denominator: all hhs where respondent has not received the vaccine yet 
gen hea4 = 0 if v02_09 != 1
replace hea4 = 1 if (v02_10==2 | v02_10==3)
la var hea4 "Percentage of respondents not vaccinated nor willing to get one (vaccination reluctancy)"

* hea5. mental health index
* definition: the average value of the following components: difficulty sleeping; anxiety, nervousness or worry; aggressive attitudes or irritability with other household members; conflicts or arguments with other people; feeling of loneliness
foreach x in b c d {
	recode v02_12`x' (98=.) (2=0)
}
egen hea5 = rowmean(v02_12b v02_12c v02_12d)

gen hea6 = v02_12b
gen hea7 = v02_12c
gen hea8 = v02_12d

**Alguna afectacion mental
gen hea9 = cond(v02_12b == 1 | v02_12c == 1 | v02_12d == 1,1,0)
replace hea9 = . if v02_12b == 98 & v02_12c == 98 & v02_12d == 98
la def hea9 0 "No sufrió ninguna afectación" 1 "Sufrió alfuna afectación"
la val hea9 hea9
la var hea9 "Indicador de afectaciones a la salud mental durante la pandemia"

*hea10. Ha recibido apoyo psicologico para abordar necesidades emocionales
gen hea10 = .
replace hea10 = 1 if v02_12f == 1
replace hea10 = 0 if v02_12f == 2
la var hea10 "Ha recibido apoyo psicologico para abordar necesidades emocionales"


*----------3.7: Digital and finance

* Modificación conteo dispositivos para excluir NS/NR
foreach x in v11_01 v11_02 v11_03 v11_04 v11_06 {
	replace `x' = . if `x' == 99
	}
*

* Percentage of households that report issues with internet connection due to high cost of internet vs. power outages
gen int_cost =.

gen power_outages =. 

* Percentage of total, existing users and new users of mobile wallet

gen old_user=. 
cap replace old_user = 1 if v11_17  ==1
cap replace old_user = 0 if (v11_17 !=1 & v11_17 !=.)
la var old_user "Antiguo usuario de mobile wallet"

gen new_user =. 
cap replace new_user = 1 if (v11_15 == 1 | v11_16 ==1) 
cap replace new_user = 0 if (v11_15 == 0 & v11_16 ==0)
cap replace new_user = 0 if (new_user == 1 & old_user ==1)
la var new_user "Nuevo usuario de mobile wallet durante la pandemia"

gen total_users=. 
replace total_users = 1 if (old_user == 1 | new_user == 1)
replace total_users = 0 if (old_user == 0 & new_user == 0)
la var total_users "Total usuarios de mobile wallet"

* Percentage of respondents who indicate an increase in the use of mobile banking vs. the use of apps/webpage for transactions

gen increase_banking=. 

gen increase_apps=. 

// Wave 2

* Sector 

forvalues x = 1(1)20 {
	gen sector`x'=. 
		replace sector`x' = 0 if (ocupado1 == 1)
		replace sector`x' = 1 if (v05_11 == `x' & ocupado1 == 1 )
}

forvalues x = 1(1)20 {
	gen sector_before`x'=. 
		replace sector_before`x' = 0 if (ocupado0 == 1)
		replace sector_before`x' = 1 if (rama0 == `x' & ocupado0 == 1)
}


**sectores agregados 

g s_health 			= (sector12==1) if ocupado1_e==1
g s_health_pre  	= (sector_before12==1 ) if ocupado0_e==1

g s_education		 = (sector11==1) if ocupado1_e==1
g s_education_pre    = (sector_before11==1) if ocupado0_e==1

g s_agriculture 	 = (sector1==1) if ocupado1_e==1
g s_agriculture_pre  = (sector_before1==1) if ocupado0_e==1

g s_industry 	     = (sector2==1 | sector3==1 | sector5 == 1 ) 				   if ocupado1_e==1
g s_industry_pre     = (sector_before2==1 | sector_before3==1 | sector_before5==1) if ocupado0_e==1

g s_construction     = (sector6==1) 				if ocupado1_e==1
g s_construction_pre = (sector_before6==1) 			if ocupado0_e==1

g s_trade	 		= (sector8 ==1 | sector15==1)				if ocupado1_e==1
g s_trade_pre 		= (sector_before8==1 | sector_before15 ==1) if ocupado0_e==1

g s_restaurants 	= sector14==1 if ocupado1_e==1
g s_restaurants_pre = (sector_before14==1) if ocupado0_e==1

g s_domestic		= sector20==1 if ocupado1_e==1
g s_domestic_pre	= (sector_before20==1) if ocupado0_e==1

g s_transport		= (sector7==1 | sector16==1) if ocupado1_e==1
g s_transport_pre   = (sector_before7==1 | sector_before16==1) if ocupado0_e==1 

g s_arts 			= (sector10 ==1 | sector19==1) if ocupado1_e==1
g s_arts_pre 		= (sector_before10 ==1 | sector_before19==1) if ocupado0_e==1 

g s_publicadm	   = (sector4==1 | sector13==1) if ocupado1_e==1
g s_publicadm_pre  = (sector_before4==1 | sector_before13==1) if ocupado0_e==1

g s_financial	   = (sector9==1 | sector17==1 | sector18==1) if ocupado1_e==1
g s_financial_pre  = (sector_before9==1 | sector_before17==1 | sector_before18==1) if ocupado0_e==1




// FORMAL

* Formal a informal
gen t_formal_informal=. 
replace t_formal_informal=0 if formal0 == 1
replace t_formal_informal=1 if (formal0 == 1 & ocupado1 == 1 & formal1 == 0)

* Formal a desocupado
gen t_formal_desocupado=. 
replace t_formal_desocupado = 0 if formal0 == 1
replace t_formal_desocupado = 1 if (formal0 == 1 & desocupado1 == 1)

* Formal que sale de la fuerza laboral
gen t_formal_inactivo=. 
replace t_formal_inactivo=0 if formal0 == 1
replace t_formal_inactivo=1 if (formal0 == 1 & activo1 == 0)

// INFORMAL

* Informal que se vuelve formal
gen t_informal_formal=. 
replace t_informal_formal=0 if (formal0 == 0 & ocupado0 == 1)
replace t_informal_formal=1 if (formal0 == 0 & ocupado0 == 1 & formal1 == 1)

* Informal que se queda desempleado
gen t_informal_desocupado=. 
replace t_informal_desocupado = 0 if (formal0 == 0 & ocupado0 == 1)
replace t_informal_desocupado = 1 if (formal0 == 0 & ocupado0 == 1 & desocupado1 ==1)

* Informal que se va de la fuerza del trabajo
gen t_informal_inactivo=. 
replace t_informal_inactivo= 0 if (formal0 == 0 & ocupado0 == 1)
replace t_informal_inactivo= 1 if (formal0 == 0 & ocupado0 == 1 & activo1 ==0)

// NO EMPLEADO

*no empleado a formal
gen t_fuera_formal=. 
replace t_fuera_formal = 0 if ocupado0 == 0 
replace t_fuera_formal = 1 if (ocupado0 == 0 & formal1 == 1)

*no empleado a informal 

gen t_fuera_informal=. 
replace t_fuera_informal = 0 if ocupado0 == 0 
replace t_fuera_informal = 1 if (ocupado0 == 0 & ocupado1 == 1 & formal1 == 0)

//cuts

gen hh_female =.
replace hh_female = 0 if v03_10d == 1
replace hh_female = 1 if v03_10d == 2 


gen hh_male =. 
replace hh_male = 0 if v03_10d == 2
replace hh_male = 1 if v03_10d == 1

gen hh_female_r = v03_01 ==1 & hh_female==1
gen hh_male_r = v03_01 ==1 & hh_female==0

gen hh_male_n =1 if hh_male ==1 & v03_01==1
gen hh_female_n =1 if hh_female ==1 & v03_01==1

gen I_hh_female=. 
replace I_hh_female = 0 if (v03_10d ==1 | v03_10d ==2)
replace I_hh_female = 1 if hh_female == 1 & female == 1

gen I_hh_male=. 
replace I_hh_male = 0 if (v03_10d ==1 | v03_10d ==2) 
replace I_hh_male = 1 if hh_female == 1 & male == 1

gen I_hh_female_m=. 
replace I_hh_female_m = 0 if (v03_10d ==1 | v03_10d ==2)
replace I_hh_female_m = 1 if hh_female == 0 & female == 1

gen I_hh_male_m=. 
replace I_hh_male_m = 0 if (v03_10d ==1 | v03_10d ==2) 
replace I_hh_male_m = 1 if hh_female == 0 & male == 1


gen N_hh_female=. 
replace N_hh_female = 0 if (v03_10d ==1 | v03_10d ==2) 
replace N_hh_female = 1 if hh_male == 1 & female == 1

gen N_hh_male=. 
replace N_hh_male = 0 if (v03_10d ==1 | v03_10d ==2) 
replace N_hh_male = 1 if hh_female == 1 & male == 1

// variables

g int_head= (v03_00b==1)

destring folio, replace force


