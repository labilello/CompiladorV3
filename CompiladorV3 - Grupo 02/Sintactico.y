%{
/******** INCLUDES **********/
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include "inc\primitivas_pila_dinamica.c"
#include "y.tab.h"
/****************************/

/********* DEFINES Y VARS GLOBALES ************/
int yystopparser=0;
FILE *yyin;
void exportarTablas();
/**********************************************/

/****** ELEMENTOS DE LAS PILAS  *********/
t_pila pilaPos;
t_pila pilaRepeat;
t_pila pilaFiltro;
/**********************************/


/************* ELEMENTOS NECESARIOS PARA TERCERTOS ********/
typedef struct
{
   int indice;      //INDICE DE TERCETO
   char dato1[40];  //OPERACION
   char dato2[40];  //OPERADOR1
   char dato3[40];  //OPERADOR2
} regTerceto;

regTerceto terceto;
regTerceto tablaTerceto[2048];

int numeroTerceto = 0;
char valorConstante[50];
char aux1[31], aux2[31], opSalto[6];

int indice_constante;
int indice_termino;
int indice_factor;
int indice_expresion;

int indice_condicion;
int indice_condicionI;
int indice_condicionD;

int indice_comparacion;
int indice_comparacionD;
int indice_comparacionI;

int indice_repeat;
int indice_filtro;

int indice_out;
int indice_in;

int indice_if;

int crearTerceto(char *operador, char *operando1, char *operando2);
void mostrarTerceto();
void modificarTerceto(int posicion, int inc);
char* negarSalto(char* operadorSalto);
/**********************************************************************/

/****************** ELEMENTOS NECESARIOS PARA IDS *********************/
#define MAX_IDS 20
typedef struct
{
   char nombre[31];
   char tipo[31];
   char valor[31];
   char longitud[5];
} regId;

regId tablaId[2048];
int numeroId = 0;

char cadAux[50];
char ids[MAX_IDS][32];
char tipoid[MAX_IDS][32];
int cantIds = 0;
int canttipos = 0;

int idAsig1;
int idAsig2;

void insertarIDs();
void mostrarID();
int existeID(char* id);
void insertarConstante(char* nombre, char* tipo, char* valor);
/***********************************************************************/
/*                   ELEMENTOS NECESARIOS PARA ASSEMBLER               */
typedef struct {
  int indice;
  char aux[20];
}tipoTercetoAsm;

regTerceto tercetoArchivo;
tipoTercetoAsm tercetoLeido[2048];
char aux[10];
char cteAux[50];
char underscore[50];

void generarAssembler(void);
void crearTercetoAsm(int ind, char *varAux);
int tipoElemento(char *); // funcion para obtener el tipo del elemento
void crearFloat(char *); /* funcion para cambiar los puntos de una variable
                           float a un _ para poder llamarla como cte sin nombre */
void crearInstruccion(FILE *,char *,char *,char *, char *);
/* Condensa la funcion fprintf con un formato ""%s\t%s\t%s\t%s\n" */
void leerTerceto(char*);
/* Recibe una linea del archivo de tercetos, y lo pasa a la estructura de tercetos */
void crearValor(FILE *);
void crearFADD(FILE *);
void crearFSUB(FILE *);
void crearFMUL(FILE *);
void crearFDIV(FILE *);

/***********************************************************************/
%}


%union {
	int intval;
	double val;
	char *str_val;
}
%start start
%token <str_val>ID <int>CTE_E <double>CTE_R <str_val>CTE_S
%token C_REPEAT_A C_REPEAT_C C_IF_A C_IF_E
%token C_FILTER C_FILTER_REFENTEROS
%token PRINT READ
%token VAR ENDVAR CONST INTEGER FLOAT STRING
%token OP_ASIG OP_SUMA OP_RESTA OP_MUL OP_DIV
%token PARENTESIS_A PARENTESIS_C LLAVE_A LLAVE_C CORCHETE_A CORCHETE_C COMA PYC DOSPUNTOS
%token OP_IGUAL OP_DISTINTO OP_MENOR OP_MENORIGUAL OP_MAYOR OP_MAYORIGUAL OP_LOGICO_AND OP_LOGICO_OR OP_NEGACION


%%

start				:		archivo ; /* SIMBOLO INICIAL */

/* DECLARACION GENERAL DE PROGRAMA
	- DECLARACIONES Y CUERPO DE PROGRAMA
	- CUERPO DE PROGRAMA
*/
archivo				:		VAR bloqdeclaracion ENDVAR bloqprograma {exportarTablas();} ;

/* REGLAS BLOQUE DE DECLARACIONES */
bloqdeclaracion		:		bloqdeclaracion declaracion ;
bloqdeclaracion		:		declaracion ;

declaracion			:		CORCHETE_A listatipos CORCHETE_C DOSPUNTOS CORCHETE_A listavariables CORCHETE_C PYC {insertarIDs();};

listatipos			:		listatipos COMA listadato	|
							listadato					;

listadato			:		INTEGER {sprintf(tipoid[canttipos++], "%s", "INTEGER"); }	|
							FLOAT	{sprintf(tipoid[canttipos++], "%s", "FLOAT"); }		;

listavariables		:		listavariables COMA ID {strcpy(cadAux,yylval.str_val); strcpy(ids[cantIds], strtok(cadAux," ,:"));cantIds++;}	|
							ID{strcpy(cadAux,yylval.str_val); strcpy(ids[cantIds], strtok(cadAux," ,:"));cantIds++;}						;
/* FIN REGLAS BLOQUE DE DECLARACIONES */

/* REGLAS BLOQUE DE CUERPO DE PROGRAMA */

bloqprograma		:		bloqprograma sentencia ;
bloqprograma		:		sentencia ;

sentencia			:		constante	|
							asignacion 	|
							decision	|
							bucle		|
							leer		|
							imprimir	|
							filtro		; /*SACAR*/

tiposoloid			: 		ID {strcpy(aux1, yylval.str_val);};

constante			:		CONST tiposoloid OP_ASIG CTE_E
							{	itoa(yylval.intval, valorConstante, 10);} PYC
							{	indice_constante = crearTerceto("=", aux1, valorConstante);
								insertarConstante(aux1, "CONST_INTEGER", valorConstante);
							}		|
							CONST tiposoloid OP_ASIG CTE_R
							{	gcvt(yylval.val, 10, valorConstante);} PYC
							{	indice_constante = crearTerceto("=", aux1, valorConstante);
								insertarConstante(aux1, "CONST_FLOAT", valorConstante);
							}		|
							CONST tiposoloid OP_ASIG CTE_S
							{	strcpy(valorConstante, yylval.str_val);} PYC
							{	indice_constante = crearTerceto("=", aux1, valorConstante);
								insertarConstante(aux1, "CONST_STRING", valorConstante);
							}		;

asignacion			:		ID
							{	if((idAsig1 = existeID(yylval.str_val)) != -1)
									strcpy(aux1, yylval.str_val);
								else
									yyerror("SINTAX ERROR: ID no declarado anteriormente");
							}	OP_ASIG tipoasig PYC {crearTerceto("=", aux1, valorConstante);}	;
tipoasig			:		varconstante
							{ 	if(strcmp(tablaId[idAsig1].tipo, aux2) != 0)
									yyerror("SINTAX ERROR: Asignacion de dos tipos disntitos");
							}
							|
							ID
							{	if((idAsig2 = existeID(yylval.str_val)) != -1) {
									if(strcmp(tablaId[idAsig1].tipo, tablaId[idAsig2].tipo) != 0)
										yyerror("SINTAX ERROR: Asignacion de dos tipos disntitos");
									else
										strcpy(valorConstante, yylval.str_val);
								}
								else
									yyerror("SINTAX ERROR: ID no declarado anteriormente");
							}		;

varconstante		:		CTE_E
                {
                  itoa(yylval.intval, valorConstante, 10);
                  strcpy(aux2, "INTEGER");
                  strcpy(cadAux, "_");
                  insertarConstante(strcat(cadAux, valorConstante), "CONST_INTEGER", valorConstante );
                  printf("%s\n",cadAux);
                  printf("%s\n",valorConstante);

                }	|
							CTE_R
                {
                  sprintf(valorConstante, "%0.2f", (double) yylval.val);
                  strcpy(aux2, "FLOAT");
                  strcpy(cadAux, "_");
                  strcat(cadAux, valorConstante);
                  printf("%s", cadAux);
                  insertarConstante(cadAux, "CONST_FLOAT", valorConstante);
                  printf("%s\n",cadAux);
                  printf("%s\n",valorConstante);
                } 	;

decision			:		C_IF_A PARENTESIS_A condicion PARENTESIS_C LLAVE_A bloqprograma LLAVE_C
							{	modificarTerceto(desapilar(&pilaPos), 0);
							}	|
							C_IF_A PARENTESIS_A condicion PARENTESIS_C LLAVE_A bloqprograma LLAVE_C
							{	modificarTerceto(desapilar(&pilaPos), 1);
								indice_if = crearTerceto("JMP", "", "");
								apilar(&pilaPos, indice_if);
							}
							C_IF_E LLAVE_A bloqprograma LLAVE_C	{modificarTerceto(desapilar(&pilaPos), 0);}	;

bucle				:		C_REPEAT_A
							{	indice_repeat = crearTerceto("ETQ_REPEAT", "", "");
								apilar(&pilaRepeat, indice_repeat);

							}
							bloqprograma C_REPEAT_C PARENTESIS_A condicion PARENTESIS_C PYC
							{
								modificarTerceto(numeroTerceto-1, (-1)*(numeroTerceto - desapilar(&pilaRepeat) ));

							};

condicion			:		comparacion
							{	sprintf(aux1, "[ %d ]", indice_comparacion);
								indice_condicion = crearTerceto(opSalto, aux1, "--");
								apilar(&pilaPos, indice_condicion);
							}	|
							OP_NEGACION PARENTESIS_A comparacion PARENTESIS_C
							{	sprintf(aux1, "[ %d ]", indice_comparacion);
								indice_condicion = crearTerceto(negarSalto(opSalto), aux1, "");
								apilar(&pilaPos, indice_condicion);
							}	|
							comparacion_i OP_LOGICO_AND comparacion_d
							{	sprintf(aux1, "[ %d ]", indice_comparacionI);
								sprintf(aux2, "[ %d ]", indice_comparacionD);

								indice_condicion = crearTerceto("AND", aux1, aux2);

								sprintf(aux1, "[ %d ]", numeroTerceto);

								indice_condicion = crearTerceto("JZ", aux1, "");
								apilar(&pilaPos, indice_condicion);
							}	|
							comparacion_i OP_LOGICO_OR comparacion_d
							{	sprintf(aux1, "[ %d ]", indice_comparacionI);
								sprintf(aux2, "[ %d ]", indice_comparacionD);

								indice_condicion = crearTerceto("OR", aux1, aux2);

								sprintf(aux1, "[ %d ]", numeroTerceto);

								indice_condicion = crearTerceto("JZ", aux1, "");
								apilar(&pilaPos, indice_condicion);
							}	;

comparacion_i		:		comparacion { indice_comparacionI = indice_comparacion; } ;
comparacion_d		:		comparacion { indice_comparacionD = indice_comparacion; } ;


comparacion			:		expresion_i op_comparacion expresion_d
							{	sprintf(aux1, "[ %d ]", indice_condicionI);
								sprintf(aux2, "[ %d ]", indice_condicionD);

								indice_comparacion = crearTerceto("CMP", aux1, aux2);
							}	|
							filtro op_comparacion expresion_d
							{	sprintf(aux2, "[ %d ]", indice_condicionD);

								indice_comparacion = crearTerceto("CMP", "_auxFiltro", aux2);
							}	;


expresion_i			: 		expresion { indice_condicionI = indice_expresion; };
expresion_d			:		expresion { indice_condicionD = indice_expresion; };

op_comparacion      :       OP_MENOR {strcpy(opSalto, "JB");} 		|
							OP_MENORIGUAL {strcpy(opSalto, "JBE");}	|
							OP_MAYOR {strcpy(opSalto, "JA");}		|
							OP_MAYORIGUAL {strcpy(opSalto, "JAE");}	|
							OP_IGUAL {strcpy(opSalto, "JE");}		|
							OP_DISTINTO	{strcpy(opSalto, "JNE");}	;



expresion			:		termino	{ indice_expresion = indice_termino; }		|
							expresion OP_SUMA termino
							{	sprintf(aux1, "[ %d ]", indice_expresion);
								sprintf(aux2, "[ %d ]", indice_termino);

								indice_expresion = crearTerceto("ADD", aux1, aux2);
							}		|
							expresion OP_RESTA termino
							{	sprintf(aux1, "[ %d ]", indice_expresion);
								sprintf(aux2, "[ %d ]", indice_termino);

								indice_expresion = crearTerceto("SUB", aux1, aux2);
							}		;

termino				:		factor { indice_termino = indice_factor; }				|
							termino OP_MUL factor
							{
								sprintf(aux1, "[ %d ]", indice_termino);
								sprintf(aux2, "[ %d ]", indice_factor);

								indice_termino = crearTerceto("MUL", aux1, aux2);
							}	|
							termino OP_DIV factor
							{	sprintf(aux1, "[ %d ]", indice_termino);
								sprintf(aux2, "[ %d ]", indice_factor);

								indice_termino = crearTerceto("DIV", aux1, aux2);
							}	;

factor				:		ID
							{	//if(existeID(yylval.str_val))
									indice_factor = crearTerceto(yylval.str_val,"--","--");
								/*SINO ERROR PORQUE NO EXISTE*/
							}				|
							varconstante {indice_factor = crearTerceto(valorConstante, "--", "--");}	|
							PARENTESIS_A expresion PARENTESIS_C {indice_factor = indice_expresion;}	;



imprimir			:		PRINT CTE_S
              {
                char *cad;
								strcpy(aux1, yylval.str_val + 1);
                cad = strrchr(aux1, '\"');
                *cad = '\0';
                strcpy(cadAux, "_");
                insertarConstante(strcat(cadAux, aux1), "CONST_STING", aux1);
								indice_out = crearTerceto("output", aux1, "--");
							}	PYC	|
							PRINT ID {
								//if(existeID(yylval.str_val))
									strcpy(aux1, yylval.str_val);
									indice_out = crearTerceto("output", aux1, "--");
								/*SINO ERROR PORQUE NO EXISTE*/
							}	PYC	;
leer				:		READ ID	{
								//if(existeID(yylval.str_val))
									strcpy(aux1, yylval.str_val);
									indice_in = crearTerceto("input", aux1, "--");
								/*SINO ERROR PORQUE NO EXISTE*/
							}	PYC	;

filtro				:		C_FILTER PARENTESIS_A condfiltro COMA CORCHETE_A listvarfiltro CORCHETE_C PARENTESIS_C
							{	while(!pila_vacia(&pilaFiltro))
								{
									modificarTerceto(desapilar(&pilaFiltro), 0);
								}

							}	;

condfiltro			:		C_FILTER_REFENTEROS op_comparacion expresion ;
/*							C_FILTER_REFENTEROS op_comparacion expresion_i OP_LOGICO_AND C_FILTER_REFENTEROS op_comparacion expresion_d |
							C_FILTER_REFENTEROS op_comparacion expresion_i OP_LOGICO_OR C_FILTER_REFENTEROS op_comparacion expresion_d ;
*/
listvarfiltro		:		listvarfiltro COMA ID
							{	//if(existeID(yylval.str_val))
									strcpy(aux1, yylval.str_val);
									indice_filtro = crearTerceto(aux1, "--", "--");

									sprintf(aux1, "[ %d ]", indice_expresion);
									sprintf(aux2, "[ %d ]", numeroTerceto-1);
									crearTerceto("CMP", aux1, aux2);

									sprintf(aux1, "[ %d ]", numeroTerceto+3);
									crearTerceto(negarSalto(opSalto), aux1, "");

									sprintf(aux1, "[ %d ]", numeroTerceto-3);

									crearTerceto("=", "_auxFiltro", aux1);
									crearTerceto("JMP", "", "");
									apilar(&pilaFiltro, numeroTerceto-1);
								/*SINO ERROR PORQUE NO EXISTE*/
							}	|
							ID
							{	//if(existeID(yylval.str_val))
									strcpy(aux1, yylval.str_val);
									indice_filtro = crearTerceto(aux1, "", "");

									sprintf(aux1, "[ %d ]", indice_expresion);
									sprintf(aux2, "[ %d ]", numeroTerceto-1);
									crearTerceto("CMP", aux1, aux2);

									sprintf(aux1, "[ %d ]", numeroTerceto+3);
									crearTerceto(negarSalto(opSalto), aux1, "");

									sprintf(aux1, "[ %d ]", numeroTerceto-3);

									crearTerceto("=", "_auxFiltro", aux1);
									crearTerceto("JMP", "", "");
									apilar(&pilaFiltro, numeroTerceto-1);
								/*SINO ERROR PORQUE NO EXISTE*/
							}	;





%%
/* *******************************************************************************
								DESARROLLO DE FUNCIONES
	****************************************************************************** */

int main(int argc,char *argv[]){

	if ((yyin = fopen(argv[1], "rt")) == NULL){
		printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
		return 0;
	}

	/* ************ CREACION DE PILAS *********** */
	crearPila(&pilaPos);
	crearPila(&pilaRepeat);
	crearPila(&pilaFiltro);
	/* ****************************************** */



	yyparse();
	fclose(yyin);


  generarAssembler();
	return 0;
}

int yyerror(char * mensaje){
	printf("\n\n\n----- %s -----\n", mensaje);
	system ("Pause");
	exit (1);
}


int crearTerceto(char *operador, char *operando1, char *operando2)
{
	tablaTerceto[numeroTerceto].indice = numeroTerceto;

	strcpy(tablaTerceto[numeroTerceto].dato1, operador);
	strcpy(tablaTerceto[numeroTerceto].dato2, operando1);
	strcpy(tablaTerceto[numeroTerceto].dato3, operando2);
	//printf("TERCERTO: %d - OPERADOR: %s - OPERANDO1: %s - OPERANDO2: %s\n", tablaTerceto[numeroTerceto].indice, tablaTerceto[numeroTerceto].dato1, tablaTerceto[numeroTerceto].dato2, tablaTerceto[numeroTerceto].dato3);
	return numeroTerceto++;
}

void modificarTerceto(int posicion, int inc)
{
	//printf("REEMPLAZANDO: POS %d - INC %d - NUMTERCERO %d\n", posicion, inc, numeroTerceto);
	//printf("EN POS: %s - %s - %s\n", tablaTerceto[posicion].dato1, tablaTerceto[posicion].dato2, tablaTerceto[posicion].dato3);

	sprintf(tablaTerceto[posicion].dato2, "[ %d ]", numeroTerceto + inc);
	//itoa((numeroTerceto + inc), tablaTerceto[posicion].dato2, 10);

}

void mostrarTerceto()
{
  int i;
	for(i = 0; i < numeroTerceto; i++)
		printf("TERCERTO: %d - OPERADOR: %s - OPERANDO1: %s - OPERANDO2: %s\n", tablaTerceto[i].indice, tablaTerceto[i].dato1, tablaTerceto[i].dato2, tablaTerceto[i].dato3);

}

char* negarSalto(char* operadorSalto)
{
	if (strcmp(operadorSalto, "JE") == 0) // IGUAL
	{
		return "JEN"; // DISTINTO
	}
	if (strcmp(operadorSalto, "JNE") == 0) // DISTINTO
	{
		return "JE"; //IGUAL
	}
	if (strcmp(operadorSalto, "JB") == 0) // MENOR
	{
		return "JAE"; // MAYOR O IGUAL
	}
	if (strcmp(operadorSalto, "JA") == 0) //MAYOR
	{
		return "JBE"; //MENOR O IGUAL
	}
	if (strcmp(operadorSalto, "JBE") == 0) //MENOR O IGUAL
	{
		return "JA";	//MAYOR
	}
	if (strcmp(operadorSalto, "JAE") == 0) //MAYOR O IGUAL
	{
		return "JB"; //MENOR
	}
	if (strcmp(operadorSalto, "JZ") == 0) //
	{
		return "JNZ";
	}
	if (strcmp(operadorSalto, "JNZ") == 0)
	{
		return "JZ";
	}
}

void insertarIDs(){
  int i;
	if(cantIds > canttipos) {
		cantIds = canttipos;
	}
	for(i = 0; i < cantIds ; i++) {
		/*SI NO EXISTE, INSERTO*/
		if(existeID(ids[i]) == -1)
		{
			strcpy(tablaId[numeroId].nombre, ids[i]);
			strcpy(tablaId[numeroId].tipo, tipoid[i]);
			strcpy(tablaId[numeroId].valor, "--");
			strcpy(tablaId[numeroId].longitud, "");
			numeroId++;
		}
		/*SI EXISTE, ERROR*/
	}

	memset( ids, '\0', MAX_IDS );
	memset( tipoid, '\0', MAX_IDS );
	cantIds = 0;
	canttipos = 0;


}

void insertarConstante(char* nombre, char* tipo, char* valor)
{
	char auxLongitud[31];

	if(existeID(nombre) == -1) {
		strcpy(tablaId[numeroId].nombre, nombre);
		strcpy(tablaId[numeroId].tipo, tipo);
		strcpy(tablaId[numeroId].valor, valor);
		if(strcmp(tipo, "STRING") == 0){
			sprintf(tablaId[numeroId].longitud, "%d", strlen(tablaId[numeroId].valor) - 2);
		}
		else
			strcpy(tablaId[numeroId].longitud, "");

		numeroId++;
	}
	/* SINO ERROR PORQUE YA EXISTE*/


}

void mostrarID()
{
  int i;
	for( i = 0; i < numeroId; i++)
		printf("ID: %d - NOMBRE: %s - TIPO: %s - VALOR: %s - LONGITUD: %s\n", i, tablaId[i].nombre, tablaId[i].tipo, tablaId[i].valor, tablaId[i].longitud);

}

int existeID(char* id)
{
  int i;
	for(i = 0; i < numeroId; i++)
	{
		if(strcmp(tablaId[i].nombre, id) == 0)
			return i;
	}
	return -1;
}



/* EXPORTACION DE TABLAS */
void exportarTablas()
{
  int i;
	FILE *ts = fopen("ts.txt", "wt");
	FILE *intermedia = fopen("intermedia.txt", "wt");

	fprintf(ts, "NOMBRE\t\t\t\tTIPO\t\t\t\tVALOR\t\t\tLONGITUD\n");

	for(i = 0; i < numeroId; i++) {
		fprintf(ts, "%-30s%-30s%-30s%s\n", tablaId[i].nombre, tablaId[i].tipo, tablaId[i].valor, tablaId[i].longitud);
	}


	for(i = 0; i < numeroTerceto; i++) {
		fprintf(intermedia, "|  %d  | ( %s, %s, %s )\n", tablaTerceto[i].indice, tablaTerceto[i].dato1, tablaTerceto[i].dato2, tablaTerceto[i].dato3);
	}

	fclose(ts);
	fclose(intermedia);

}
//*
int tipoElemento(char *elemento){

	//valores del return
	//1: Constante entera
	//2: Constante real
	//3: Constante string
	//4: Variable entera
	//5: Variable real
	//-1: Error, no fue encntrado

	FILE * TS;
	char id[50];
	char tipo[30];
	char valor[50];
	char aux[500];
	int tam;
	TS=fopen("ts.txt","rt");

	fscanf(TS,"%30s%30s%30s%s\n",id,tipo,valor,aux);

	while(fscanf(TS,"%30s%30s%30s%02d\n",id,tipo,valor,&tam)==4){
		if(strcmp(valor,elemento)==0){//es una constante
			if(strcmp(tipo,"CONST_INTEGER")==0){
				return 1;
			}else{
				if(strcmp(tipo,"CONST_FLOAT")==0){
					return 2;
				}else{
					if(strcmp(tipo,"CONST_STRING")==0){
						return 3;
					}
				}
			}
		}else{
			if(strcmp(valor,"--")==0){//es una variable
				if(strcmp(id,elemento)==0){
					if(strcmp(tipo,"INTEGER")==0){
						return 4;
					}else{
						if(strcmp(tipo,"FLOAT")==0){
							return 5;
						}
					}
				}
			}
		}

	}
	fclose(TS);
	return -1;
}

void crearInstruccion(FILE *pf,char *c1,char *c2,char *c3, char *c4){
  fprintf(pf, "%s\t%s\t%s\t%s\n", c1, c2, c3, c4);
}

// GENERACION DE ASSEMBLER
//asumo que todas los numeros son float

void generarAssembler(){
  int tipo;
  int i = 0;
  char linea[50];
  FILE *codAssembler;
	FILE *intermedia = fopen("intermedia.txt", "rt");
  if(intermedia == NULL){
    printf("%s\n", "No pudo abrir el archivo de tercetos");
    return;
  }
  codAssembler = fopen("Final.asm", "wt");
  if(codAssembler == NULL){
    printf("%s\n", "No pudo abrir el archivo Final");
    fclose(intermedia);
    return;
  }

	fprintf(codAssembler, "include macros2.asm\n");
	fprintf(codAssembler,	"include number.asm\n\n");
	fprintf(codAssembler, ".MODEL LARGE\n");
	fprintf(codAssembler, ".386\n");
	fprintf(codAssembler, ".STACK 200h\n\n");
	fprintf(codAssembler, "MAXTEXTSIZE equ 50\n\n");
	fprintf(codAssembler, ".DATA\n");

  //printf("%s", linea);
  while( fgets(linea, sizeof(linea), intermedia) != NULL )
  {
    //fscanf(intermedia, "|  %02d  | ( %s, %s, %s )",&(tercetoArchivo.indice), tercetoArchivo.dato1,tercetoArchivo.dato2,tercetoArchivo.dato3);
    i++;
    printf("%s", linea);
    leerTerceto(linea);
    if(strcmp(tercetoArchivo.dato2, "--") == 0 && strcmp(tercetoArchivo.dato3, "--") == 0)
    {
      crearValor(codAssembler);
    }

    if(strcmp(tercetoArchivo.dato1, "ADD") == 0)
    {
      crearFADD(codAssembler);
    }

    if(strcmp(tercetoArchivo.dato1, "SUB") == 0)
    {
      crearFSUB(codAssembler);
    }

    if(strcmp(tercetoArchivo.dato1, "MUL") == 0)
    {
      crearFMUL(codAssembler);
    }

    if(strcmp(tercetoArchivo.dato1, "DIV") == 0)
    {
      crearFDIV(codAssembler);
    }

  }
  fclose(intermedia);
  fclose(codAssembler);
}

void leerTerceto(char *linea)
{
  char aux[50];
  char *pini = strchr(linea, '|');
  char *pfin;
  pini += 3;
  pfin = strchr(pini, ' ');
  *pfin = '\0';
  strcpy(aux, pini);
  tercetoArchivo.indice = atoi(aux);
  pini = pfin + 1;
  pini = strchr(pini, '(');
  pini += 2;
  pfin = strchr(pini, ',');
  *pfin = '\0';
  strcpy(aux, pini);
  strcpy(tercetoArchivo.dato1, aux);
  pini = pfin + 2;// Sumo 2, por que despues de la coma en cada terceto hay un espacio
  pfin = strchr(pini, ',');
  *pfin = '\0';
  strcpy(aux, pini);
  strcpy(tercetoArchivo.dato2, aux);
  pini = pfin + 2;
  pfin = strchr(pini, ')');
  --pfin;
  *pfin = '\0';
  strcpy(aux, pini);
  strcpy(tercetoArchivo.dato3, aux);
}

void crearValor(FILE *pf)
{
  char buffer[20];
  char op[10] = "FLD ";
  /*int tipo = tipoElemento(tercetoArchivo.dato1);
  if(tipo == 1)
  {
    strcpy(operacion, "FILD");
    strcpy(cteAux, "_");
    strcat(cteAux, tercetoArchivo.dato1);
    crearInstruccion(pf, "\t", "FILD", cteAux, "");
    strcpy(aux, "@aux");
    strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
    strcat(aux, " ");
    strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
    crearInstruccion(pf, "\t", "FISTP", aux, "");
  }
  if(tipo == 4)
  {
    strcpy(operacion, "FILD");
    crearInstruccion(pf, "\t", "FILD", tercetoArchivo.dato1, "");
    strcpy(aux, "@aux");
    strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
    strcat(aux, " ");
    strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
    crearInstruccion(pf, "\t", "FISTP", aux, "");
  }
  if(tipo == 3){
    return;
  }
  if(tipo == 2)
  {
    strcpy(operacion, "FLD ");
    strcpy(cteAux, "_");
    crearFloat(tercetoArchivo.dato1);
    strcat(cteAux, tercetoArchivo.dato1);
    crearInstruccion(pf, "\t", operacion, cteAux, "");
    strcpy(aux, "@aux");
    strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
    strcat(aux, " ");
    strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
    crearInstruccion(pf, "\t", "FSTP", aux, "");
  }
  if(tipo == 5)
  {*/
    crearFloat(tercetoArchivo.dato1);
    strcpy(underscore, "_");
    strcat(underscore, tercetoArchivo.dato1);
    crearInstruccion(pf, "\t", op, underscore, "");
    strcpy(aux, "@aux");
    strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
    strcat(aux, " ");
    strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
    crearInstruccion(pf, "\t", "FSTP", aux, "");
  //}
}

void crearFloat(char *valor){
  int i;
  for (i=0;i<strlen(valor);i++){
    if (valor[i] == '.'){
      valor[i] = '_';
    }
  }
}

void crearFADD(FILE *pf)
{
  char buffer[20];
  char *cad;
  int i;
  cad = strrchr(tercetoArchivo.dato2, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato2,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t", "FLD ", tercetoLeido[atoi(cad)].aux, "");
  cad = strrchr(tercetoArchivo.dato3, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato3,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t","FADD", tercetoLeido[atoi(cad)].aux, "");
  strcpy(aux, "@aux");
  strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
  strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
  crearInstruccion(pf, "\t", "FSTP", aux, "");
}

void crearFSUB(FILE *pf)
{
  char buffer[20];
  char *cad;
  int i;
  cad = strrchr(tercetoArchivo.dato2, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato2,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t", "FLD ", tercetoLeido[atoi(cad)].aux, "");
  cad = strrchr(tercetoArchivo.dato3, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato3,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t","FSUB", tercetoLeido[atoi(cad)].aux, "");
  strcpy(aux, "@aux");
  strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
  strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
  crearInstruccion(pf, "\t", "FSTP", aux, "");
}

void crearFMUL(FILE *pf)
{
  char buffer[20];
  char *cad;
  int i;
  cad = strrchr(tercetoArchivo.dato2, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato2,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t", "FLD ", tercetoLeido[atoi(cad)].aux, "");
  cad = strrchr(tercetoArchivo.dato3, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato3,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t","FMUL", tercetoLeido[atoi(cad)].aux, "");
  strcpy(aux, "@aux");
  strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
  strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
  crearInstruccion(pf, "\t", "FSTP", aux, "");
}

void crearFDIV(FILE *pf)
{
  char buffer[20];
  char *cad;
  int i;
  cad = strrchr(tercetoArchivo.dato2, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato2,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t", "FLD ", tercetoLeido[atoi(cad)].aux, "");
  cad = strrchr(tercetoArchivo.dato3, ']');
  *cad = '\0';
  cad = strchr(tercetoArchivo.dato3,'[');
  cad++; // Salteo el espacio entre el corchete y el indice
  crearInstruccion(pf, "\t","FDIV", tercetoLeido[atoi(cad)].aux, "");
  strcpy(aux, "@aux");
  strcat(aux, itoa(tercetoArchivo.indice, buffer, 10));
  strcpy(tercetoLeido[tercetoArchivo.indice].aux, aux);
  crearInstruccion(pf, "\t", "FSTP", aux, "");
}
