ifeq ($(strip $(PVSNESLIB_HOME)),)
$(error "Please create an environment variable PVSNESLIB_HOME with path to its folder and restart application. (you can do it on windows with <setx PVSNESLIB_HOME "/c/snesdev">)")
endif

#AUDIOFILES := whatislove.it
#export SOUNDBANK := soundbank

include ${PVSNESLIB_HOME}/devkitsnes/snes_rules

.PHONY: bitmaps all

#---------------------------------------------------------------------------------
# ROMNAME is used in snes_rules file
export ROMNAME := snesSPC

#SMCONVFLAGS	:= -s -o $(SOUNDBANK) -v -b 5
#musics: $(SOUNDBANK).obj

#all: musics bitmaps $(ROMNAME).sfc
all: bitmaps $(ROMNAME).sfc

clean: cleanBuildRes cleanRom cleanGfx cleanAudio
	
#---------------------------------------------------------------------------------
pvsneslibfont.pic: pvsneslibfont.bmp
	@echo convert font with no tile reduction ... $(notdir $@)
	$(GFXCONV) -n -gs8 -po2 -pc16 -pe1 -mR! -m! -p! $<

bitmaps : pvsneslibfont.pic
