package Disciplinas;

import java.util.ArrayList;

public class Disciplina {
     private String nome;
     private double notaP1;
     private double notaP2;

    public Disciplina(String nome){
        this.nome = nome;
    }
  
    public String getNome(){
        return nome;
    }
    
    public void setNome(String nome){
        this.nome = nome;
    } 
     
    public double getnotaP1(){
        if(notaP1 < 0)
            this.notaP1 = 0;
        else if (notaP1 <= 10)
            this.notaP1 = notaP1;
        else 
            this.notaP1 = 10;
        return notaP1;
    }
    
    public void setNotaP1(double notaP1){
        this.notaP1 = notaP1;
    } 
      
    public double getnotaP2(){
        if(notaP2 < 0)
            this.notaP2 = 0;
        else if (notaP2 <= 10)
            this.notaP2 = notaP2;
        else 
            this.notaP2 = 10;
        return notaP2;
    }
    
    public void setNotaP2(double notaP2){
        this.notaP2 = notaP2;
    } 
 
    public static ArrayList getList(){
        ArrayList<Disciplina> disciplinas = new ArrayList<>();
        
        disciplinas.add(new Disciplina("Engenharia de Software III"));
        disciplinas.add(new Disciplina("Linguagem de Programação IV"));
        disciplinas.add(new Disciplina("Programação Orientada a Objetos"));
        disciplinas.add(new Disciplina("Segurança da Informação"));
        disciplinas.add(new Disciplina("Sistemas Operacionais II"));
        disciplinas.add(new Disciplina("Programação para Dispositivos Móveis"));
        disciplinas.add(new Disciplina("Inglês V"));
        
        return disciplinas;   
    };
}