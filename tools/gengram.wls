#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Text:: *)
(*This script generates the symbols from the current MMa version that the textmate syntax file uses.*)


sysnames = Names["System`*"];


preconsts = ToString/@{True,False,Null,None,Nothing,All,Automatic,Anonymous,Full,Inherited,Manual,Infinity};


consts = Join[preconsts,Select[sysnames,MemberQ[Attributes[#],Constant]&]];
globals = Select[sysnames,StringMatchQ[#,RegularExpression["^\$.*"]]&];
nfunc = Select[sysnames,MemberQ[Attributes[#],NumericFunction]&];
(* for now, just merge in the nfunc *)
rest = Join[nfunc,Select[Complement[sysnames,consts,globals,nfunc],StringLength[#]>1&]];


parentPath = $InputFileName /. "" :> NotebookFileName[];
parentDir = DirectoryName @ parentPath;
dir = FileNameJoin[{parentDir,StringJoin[ToString[$VersionNumber],".",ToString[$ReleaseNumber]]}];


Quiet[CreateDirectory[dir]];


(* ::Code::Initialization:: *)
(*Export[FileNameJoin[{dir,"consts.dat"}],{consts},"TextDelimiters" -> "","FieldSeparators"->"|"];*)
(*Export[FileNameJoin[{dir,"globals.dat"}],{globals},"TextDelimiters" -> "","FieldSeparators"->"|"];*)
(*Export[FileNameJoin[{dir,"numeric.dat"}],{nfunc},"TextDelimiters" -> "","FieldSeparators"->"|"];*)
(*Export[FileNameJoin[{dir,"rest.dat"}],{rest},"TextDelimiters" -> "","FieldSeparators"->"|"];*)


Export[FileNameJoin[{dir,"constants.json"}],consts];
Export[FileNameJoin[{dir,"globals.json"}],globals];
Export[FileNameJoin[{dir,"rest.json"}],rest];
