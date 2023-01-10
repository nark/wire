//
//  transfers.h
//  wire
//
//  Created by Rafaël Warnault on 10/02/12.
//  Copyright (c) 2012 OPALE. All rights reserved.
//

#ifndef WR_TRANSFERS_H
#define WR_TRANSFERS_H 1

#include "files.h"

#define WR_TRANSFERS_SUFFIX			".WiredTransfer"

enum _wr_transfer_type {
	WR_TRANSFER_DOWNLOAD			= 0,
	WR_TRANSFER_UPLOAD
};
typedef enum _wr_transfer_type		wr_transfer_type_t;


enum _wr_transfer_state {
	WR_TRANSFER_WAITING				= 0,
	WR_TRANSFER_LISTING,
	WR_TRANSFER_QUEUED,
	WR_TRANSFER_RUNNING,
	WR_TRANSFER_FINISHED
};
typedef enum _wr_transfer_state		wr_transfer_state_t;


typedef wi_uinteger_t				wr_tid_t;

struct _wr_transfer {
	wi_runtime_base_t				base;
	
	wr_tid_t						tid;
	wr_transfer_state_t				state;
	wr_transfer_type_t				type;
	wi_boolean_t					recursive;
	wi_boolean_t					listed;
	
	wi_socket_t						*socket;
	wi_file_t						*file;
	
	wi_string_t						*name;
	wi_string_t						*master_path;
	wi_string_t						*source_path;
	wi_mutable_array_t				*remote_paths;
	wi_mutable_array_t				*local_paths;
	wi_mutable_array_t				*files;
	
	wi_string_t						*key;
	wi_string_t						*checksum;
	
	uint32_t						queue;
	wi_time_interval_t				start_time;
    
	wi_file_offset_t				file_offset;
	wi_file_offset_t				total_offset;
	wi_file_offset_t				file_size;
	wi_file_offset_t				total_size;
	wi_file_offset_t				file_transferred;
	wi_file_offset_t				total_transferred;
	uint32_t						speed;
};
typedef struct _wr_transfer			wr_transfer_t;


void								wr_transfers_init(void);
void								wr_transfers_clear(void);

wi_integer_t						wr_runloop_download_callback(wi_socket_t *);
wi_integer_t						wr_runloop_upload_callback(wi_socket_t *);

void								wr_transfers_set_download_path(wi_string_t *);

void								wr_transfers_download(wi_string_t *);
void								wr_transfers_upload(wi_string_t *);

wr_transfer_t *						wr_transfers_transfer_with_tid(wr_tid_t);
wr_transfer_t *						wr_transfers_transfer_with_remote_path(wi_string_t *);
wr_transfer_t *						wr_transfers_transfer_with_socket(wi_socket_t *);

wr_transfer_t *						wr_transfer_alloc(void);
wr_transfer_t *						wr_transfer_init(wr_transfer_t *);
wr_transfer_t *						wr_transfer_init_download(wr_transfer_t *);
wr_transfer_t *						wr_transfer_init_upload(wr_transfer_t *);

void								wr_transfer_download_add_files(wr_transfer_t *, wi_array_t *);
void								wr_transfer_download_add_file(wr_transfer_t *, wr_file_t *, wi_boolean_t);
wi_boolean_t						wr_transfer_upload_add_file(wr_transfer_t *, wr_file_t *);
void								wr_transfer_upload_remove_files(wr_transfer_t *, wi_array_t *);

void								wr_transfer_start(wr_transfer_t *);
void								wr_transfer_start_next_or_stop(wr_transfer_t *);
void								wr_transfer_request(wr_transfer_t *);
void								wr_transfer_open(wr_transfer_t *, wi_file_offset_t, wi_string_t *);
void								wr_transfer_close(wr_transfer_t *);
void								wr_transfer_stop(wr_transfer_t *);


extern wi_string_t					*wr_download_path;
extern wi_array_t					*wr_transfers;
extern wi_boolean_t					wr_transfers_recursive_upload;


#endif
