/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fatecpg.web;

import java.util.ArrayList;

/**
 *
 * @author RodrigoLopes
 */
public class DatabaseContato {
    private static ArrayList<Contato> contatos;
    public static ArrayList<Contato> getContatos(){
            if(contatos==null){
            contatos = new ArrayList<>();
            contatos.add(
                new Contato(
                    "rodrigo", 
                    "13 9797-9797",
                    "rodrigo@domain.com")
            );
        }
        return contatos;
    }
    
    public static Contato getContato(String name, String telefone, String email){
        for(Contato contato: getContatos()){
            if(contato.getName().equals(name) 
                    && contato.getTelefone().equals(telefone) 
                    && contato.getEmail().equals(email)){
                return contato;
            }
        }
        return null;
    }
    
    public static void addContato(Contato newContato){
        getContatos().add(newContato);
    }
    
    public static void removeContato(String email){
        for(int i=0 ; i< contatos.size(); i++){
            if(contatos.get(i).getEmail().equals(email)){
                getContatos().remove(i);
            }
        }
    }
 }
