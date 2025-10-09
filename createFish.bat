md 1_HARD\1_prj
md 1_HARD\2_sch
md 1_HARD\3_pcb
md 1_HARD\4_PKI
md 1_HARD\5_Fabrication

md 2_SOFT
md 3_DOC

cd 1_HARD
@echo *.*>.gitignore
@echo !*.PrjPCB>>.gitignore
@echo !*.SchDoc>>.gitignore
@echo !*.PcbDoc>>.gitignore
@echo !*.OutJob>>.gitignore
