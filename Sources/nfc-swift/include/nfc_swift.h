//
//  nfc-buffer.h
//  
//
//  Created by Christopher Hotchkiss on 6/15/24.
//

#ifndef nfc_swift_h
#define nfc_swift_h

#include <nfc/nfc-types.h>
#include <nfc/nfc.h>

#define MAX_DEVICE_CON_STRINGS 16

NFC_EXPORT char* nfc_list_devices_swift(nfc_context *context, size_t *devices_found, size_t *buffer_item_size);

NFC_EXPORT nfc_connstring* create_nfc_connstring_array();
NFC_EXPORT void free_nfc_connstring_array(char* con_strings);

#endif /* nfc_swift_h */
