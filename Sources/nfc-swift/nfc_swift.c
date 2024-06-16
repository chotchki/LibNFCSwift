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

NFC_EXPORT void free_nfc_connstring_array(char** con_strings){
    if(con_strings != NULL && *con_strings != NULL){
        free(*con_strings);
    }
}

NFC_EXPORT size_t nfc_list_devices_swift(nfc_context *context, char **connect_strings, size_t *buffer_item_size){
    nfc_connstring connstrings[MAX_DEVICE_CON_STRINGS];
    
    *buffer_item_size = NFC_BUFSIZE_CONNSTRING;
    size_t devices_found = nfc_list_devices(context, connstrings, MAX_DEVICE_CON_STRINGS);
    
    if(devices_found == 0){
        connect_strings = NULL;
        return 0;
    }
    
    char* buffer_ptr = malloc(sizeof(nfc_connstring) * devices_found);
    if(buffer_ptr == NULL){
        return NULL;
    }
    
    memcpy(buffer_ptr, connstrings, sizeof(nfc_connstring) * devices_found);
    
    *connect_strings = buffer_ptr;
    
    return devices_found;
}
