//
//  files.h
//  wire
//
//  Created by Rafaël Warnault on 10/02/12.
//  Copyright (c) 2012 OPALE. All rights reserved.
//

#ifndef WR_FILES_H
#define WR_FILES_H 1

#include <wired/wired.h>


enum _wr_file_type {
	WR_FILE_FILE					= 0,
	WR_FILE_DIRECTORY,
	WR_FILE_UPLOADS,
	WR_FILE_DROPBOX
};
typedef enum _wr_file_type			wr_file_type_t;

typedef struct _wr_file				wr_file_t;

enum _wr_ls_state {
	WR_LS_NOTHING					= 0,
	WR_LS_LISTING,
	WR_LS_COMPLETING,
	WR_LS_COMPLETING_DIRECTORY,
	WR_LS_GLOBBING,
	WR_LS_TRANSFER
};
typedef enum _wr_ls_state			wr_ls_state_t;

enum _wr_stat_state {
	WR_STAT_NOTHING					= 0,
	WR_STAT_FILE,
	WR_STAT_TRANSFER
};
typedef enum _wr_stat_state			wr_stat_state_t;



void								wr_files_init(void);
void								wr_files_clear(void);

char *								wr_readline_filename_generator(const char *, int);

wi_string_t *						wr_files_full_path(wi_string_t *);
wi_array_t *						wr_files_full_paths(wi_array_t *);
wi_string_t *						wr_files_string_for_size(wi_file_offset_t);
wi_string_t *						wr_files_string_for_count(wi_uinteger_t);

wr_file_t *							wr_file_alloc(void);
wr_file_t *							wr_file_init_with_arguments(wr_file_t *, wi_array_t *);
wr_file_t *							wr_file_init_with_local_path(wr_file_t *, wi_string_t *);

wr_file_type_t						wr_file_type(wr_file_t *);
wi_file_offset_t					wr_file_size(wr_file_t *);
wi_string_t *						wr_file_name(wr_file_t *);
wi_string_t *						wr_file_path(wr_file_t *);


#endif /* WR_FILES_H */
