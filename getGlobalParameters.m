function [G_fg, nameNewEdge_fg, visc_fg, deltaP_fg, rotParam_fg, circleParam_fg, Lmin_fg] = getGlobalParameters()

    global globG
    global globNameNewEdge
    global globVisc 
    global globDeltaP
    global globRotParam
    global globCircleParam
    global globLmin
    
    G_fg = globG;
    nameNewEdge_fg = globNameNewEdge;
    visc_fg = globVisc;
    deltaP_fg = globDeltaP;
    rotParam_fg = globRotParam; 
    circleParam_fg = globCircleParam;
    Lmin_fg = globLmin;
end