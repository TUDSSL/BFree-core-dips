/* Objects to include in the checkpoint */
*(*.active_pincfg) /* ? Do we checkpoint this? For PWM */
*(*.last_finished_tick) /* background tasks */
*(*.last_static_clock) /* clock stuff TODO: check if we need to re-init */
*(*.low_address)
*(*.mp_interrupt_char)
*(*.mp_state_ctx)
/* *(*.nesting_count) /* -> ISR reference count? Maybe */
*(*.pulse_buffer)
*(*.pulse_index)
*(*.pulse_length)
/* *(*.pyexec_system_exit) */
*(*.refcount) /* PWM */
*(*.reload_requested)
*(*.rl)
*(*.running_background_tasks)
*(*.stack_alloc)
*(*.current_stack_size)
*(*.tc_handler) /* timer stuff TODO: need re-init */
*(*.ticks_ms)
*(*.ticks_ms_last) /* checkpoint schedule */
*(*.yasmarang_dat)
*(*.I2C_Restore)
*(*.SPI_Restore)
*(*.DigitalInOut_Restore)
*(*.AnalogIn_Restore)
*(*.NV_Time)
*(*.allocations)
*(*.low_address)
*(*.high_address)
*(*.mp_showbc_code_start)
*(*.mp_showbc_const_table)
*(*.cps_checkpoint_last_ms)
*(*.checkpoint_skipped)
*(*.checkpoint_performed)
*(*.checkpoint_restore_performed)
*(*.epd_performed_one_time_construct)
