/*
   * dna.d
   * Copyright (c) 2012 George Githinji
   * A module to represent a DNA sequence
   * This a pre-alpha version of a  bio library with the D language
   */

module dna;

import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.math;

struct nucleotide {
  public:
    /* initialize a base */
    this(char base){
      this.base = base;
    }

    /* read a base*/
    pure char get_base(){
      return base;
    }

    bool opCmp(nucleotide c){
      return base == c.base;
    }

    //string to_string(){
      //return to!String(base)
    //}

    /* private identifier */
  private:
    char base;
};


/* define nucleotide as the basic type for all nucleotide residues */
enum nucleotide_bases : nucleotide {N = nucleotide('N'), A = nucleotide('A'), T = nucleotide('T'), C = nucleotide('C'), G = nucleotide('G'),Y = nucleotide('Y'),R = nucleotide('R'), };


/* a dna sequence is an array of nucleotides */
alias nucleotide[] dna_sequence;


/* convert a stream of characters to a dna sequence */
dna_sequence to_dna(string str) {
  dna_sequence seq;
  foreach(int index,char c; str.toUpper) {
   if (is_nucleotide(c) == true){
      seq ~= cast(nucleotide)(c);
   /* create a dna string but give warning of illegal bases */
   } else {
     writefln("Warning: unrecognised nucleotide base at pos: %s", index + 1);
      seq ~= cast(nucleotide)(c);
   }
  }
return seq;
}

/* check if a base is a valid nucleotide character */
bool is_nucleotide(char base){
  if (base == nucleotide_bases.A.get_base()) return true;
  if (base == nucleotide_bases.T.get_base()) return true;
  if (base == nucleotide_bases.G.get_base()) return true;
  if (base == nucleotide_bases.C.get_base()) return true;
  if (base == nucleotide_bases.N.get_base()) return true;
  if (base == nucleotide_bases.Y.get_base()) return true;
  if (base == nucleotide_bases.R.get_base()) return true;
  //writefln("Warning: illegal nucleotide base: %s", base);
  return false;
}

/* Describe a nucleotide as a purine(R,[A or G]) or pyrimidine(Y,[C or T]) */
pure nucleotide get_type(nucleotide base){
  switch(base.get_base()){
    case nucleotide_bases.A.get_base():
      return nucleotide_bases.R;
      break;
    case nucleotide_bases.G.get_base():
      return nucleotide_bases.R;
      break;
    case nucleotide_bases.C.get_base():
      return nucleotide_bases.Y;
      break;
    case nucleotide_bases.T.get_base():
      return nucleotide_bases.Y;
      break;
    case nucleotide_bases.N.get_base():
      return nucleotide_bases.N;
      break;
    default:
      return nucleotide_bases.N;
      break;
  }
}

/*complement a nucleotide base */
pure nucleotide complement(nucleotide base){
  switch(base.get_base()){
    case nucleotide_bases.A.get_base(): 
      return nucleotide_bases.T;
      break;
    case nucleotide_bases.T.get_base(): 
      return nucleotide_bases.A;
      break;
    case nucleotide_bases.G.get_base(): 
      return nucleotide_bases.C; 
      break;
    case nucleotide_bases.C.get_base(): 
      return nucleotide_bases.G; 
      break;
    case nucleotide_bases.N.get_base(): 
      return nucleotide_bases.N; 
      break;
    default:
      // return N for illegal/unknown nucleotides
      return nucleotide_bases.N;
      break;
  }
  assert(0);
}
