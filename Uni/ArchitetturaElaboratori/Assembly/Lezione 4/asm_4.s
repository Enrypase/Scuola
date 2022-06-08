// Introduzione allo stack/PILA
// LIFO!
// push %reg / pop %reg -> Accetta solo modificatori w e l
// EBP (base pointer) base dello stack, ESP (stack pointer) indirizzo più alto dello stack

// Bisogna compilare sia main che sottoprogramma

// Con la flag di make '-j <numeroCore>' compila il codice con <numeroCore> cores

// I parametri prima dell'esecuzione del programma stanno come INDIRIZZO alla cella di memoria del parametro stesso nello stack 
// Sono salvati come stringa e oltre a questi c'è anche nome del programma + percorso assoluto e numero dei parametri (contando nome programma + percorso assoluto)

// per gdb: con x/s <registro>, stampa la stringa contenuta nel registro