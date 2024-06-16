//
//  nfc-buffer.c
//  
//
//  Created by Christopher Hotchkiss on 6/15/24.
//

#include <stdlib.h>
#include <string.h>
#include <nfc/nfc-types.h>
#include "nfc_swift.h"



NFC_EXPORT nfc_connstring* create_nfc_connstring_array(){
    
    nfc_connstring buffers[MAX_DEVICE_CON_STRINGS];
    
    nfc_connstring* buffer_ptr = malloc(sizeof(buffers));
    memset(buffer_ptr, 0, sizeof(buffers));
    
    return buffer_ptr;
}

NFC_EXPORT void free_nfc_connstring_array(char* con_strings){
    free(con_strings);
}

NFC_EXPORT char* nfc_list_devices_swift(nfc_context *context, size_t *devices_found, size_t *buffer_item_size){
    nfc_connstring connstrings[MAX_DEVICE_CON_STRINGS];
    
    buffer_item_size = NFC_BUFSIZE_CONNSTRING;
    devices_found = nfc_list_devices(context, connstrings, MAX_DEVICE_CON_STRINGS);
    
    char* buffer_ptr = malloc(sizeof(nfc_connstring) * *devices_found);
    if(buffer_ptr == NULL){
        return NULL;
    }
    
    memcpy(buffer_ptr, connstrings, sizeof(nfc_connstring) * *devices_found);
    
    return buffer_ptr;
}
