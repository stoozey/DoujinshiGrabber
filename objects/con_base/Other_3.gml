///@desc cleanup/save
directory_destroy(DIR_TEMP);

save_set(CFG_WINDOW_W, WINDOW[X]);
save_set(CFG_WINDOW_H, WINDOW[Y]);

save_set(CFG_LOW_BANDW, global.lowBandwidth);

save_set(CFG_DIR_SAVE, DIR_IMAGES);