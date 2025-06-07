SCRIPT_START
{
    NOP
    LVAR_INT sc_player , sc_car , door,sc_char ,car_stay , blip,should_break
    LVAR_FLOAT x, y ,z , distance,car_x car_y car_z,speed
    car_stay = 0
    should_break = 0
    speed = 20.0
    GET_PLAYER_CHAR 0 sc_player

    WHILE TRUE    
        WAIT 0
        
        IF TEST_CHEAT pdriver
            WAIT 0
            REQUEST_MODEL CHEETAH
            LOAD_ALL_MODELS_NOW

            //Creation     
            GET_CHAR_COORDINATES sc_player x y z
            CREATE_CAR CHEETAH x y z sc_car           
            SET_CAR_PROOFS sc_car 1 1 1 1 1
            CREATE_RANDOM_CHAR_AS_DRIVER sc_car sc_char
            WARP_CHAR_INTO_CAR_AS_PASSENGER sc_player sc_car 1000

            WHILE TRUE
                WAIT 0
                GOSUB check
                IF IS_INT_LVAR_EQUAL_TO_NUMBER should_break 1
                    should_break = 0
                    BREAK
                ENDIF 
                IF IS_KEY_PRESSED VK_KEY_W
                    PRINT_HELP_STRING "Drive mode set to wander"
                    TASK_CAR_DRIVE_WANDER sc_char sc_car 20.0 2              
                ENDIF

                IF IS_KEY_PRESSED VK_KEY_M
                    PRINT_HELP_STRING "Drive mode set to marker"
                    GET_TARGET_BLIP_COORDS x y z
                    TASK_CAR_DRIVE_TO_COORD sc_char sc_car x y z 20.0 0 0 0                                                      
                ENDIF

                IF IS_KEY_PRESSED VK_KEY_S
                    PRINT_HELP_STRING "Car has been stopped"
                    CLEAR_CHAR_TASKS_IMMEDIATELY sc_char
                    WARP_CHAR_INTO_CAR sc_char sc_car                                                
                ENDIF

                IF IS_KEY_PRESSED VK_UP
                    speed += 1.0
                    PRINT_HELP_STRING "Car speed increased by 1.0"
                    SET_CAR_FORWARD_SPEED sc_car speed     
                    WAIT 1000                                        
                ENDIF

                IF IS_KEY_PRESSED VK_DOWN
                    speed += 1.0
                    PRINT_HELP_STRING "Car speed decreased by 1.0"
                    SET_CAR_FORWARD_SPEED sc_car speed   
                    WAIT 1000                                        
                ENDIF

                IF IS_KEY_PRESSED VK_RIGHT
                    PRINT_HELP_STRING "Driving style set to normal"
                    SET_CAR_DRIVING_STYLE sc_car 0                                         
                ENDIF

                IF IS_KEY_PRESSED VK_LEFT
                    PRINT_HELP_STRING "Driving style set to very impatient"
                    SET_CAR_DRIVING_STYLE sc_car 2                                      
                ENDIF
            ENDWHILE
            MARK_MODEL_AS_NO_LONGER_NEEDED CHEETAH
        ENDIF
    ENDWHILE

    check:

    IF IS_CHAR_DEAD sc_char
        PRINT_HELP_STRING "Your driver got killed"
        SET_CAR_PROOFS sc_car 0 0 0 0 0
        WAIT 5000
        REMOVE_CHAR_ELEGANTLY sc_char
        should_break = 1
    ENDIF

    IF NOT IS_CHAR_IN_CAR sc_char sc_car
        WHILE NOT IS_CHAR_IN_CAR sc_char sc_car
            WAIT 0
            GET_CHAR_COORDINATES sc_char x y z
            GET_CAR_COORDINATES sc_car car_x car_y car_z
            GET_DISTANCE_BETWEEN_COORDS_3D x y z car_x car_y car_z distance

            IF distance > 10.0
                PRINT_HELP_STRING "You've left your driver behind."
                REMOVE_CHAR_ELEGANTLY sc_char
                SET_CAR_PROOFS sc_car 0 0 0 0 0
                should_break = 1
            ENDIF
        ENDWHILE
    ENDIF

    IF IS_CAR_DEAD sc_car
        PRINT_HELP_STRING "Your driver got scared of your car being destroyed and ran away"
        TASK_WANDER_STANDARD sc_char
        WAIT 15000
        REMOVE_CHAR_ELEGANTLY sc_char
        should_break = 1
    ENDIF

    IF IS_CHAR_DEAD sc_player
        WAIT 5000
        PRINT_HELP_STRING "Your got killed and your driver ran away"
        REMOVE_CHAR_ELEGANTLY sc_char
        DELETE_CAR sc_car
        should_break = 1
    ENDIF

    IF NOT IS_CHAR_IN_CAR sc_player sc_car
        WAIT 5000
        IF NOT IS_CHAR_IN_CAR sc_player sc_car
        AND IS_INT_LVAR_EQUAL_TO_NUMBER car_stay 0
            PRINT_HELP_STRING "You have left your vehicle.Hold 'Y' to make it wait until you return"
            WAIT 1000
            IF NOT IS_KEY_PRESSED VK_KEY_Y
                TASK_CAR_DRIVE_WANDER sc_char sc_car 20.0 2
                WAIT 15000
                REMOVE_CHAR_ELEGANTLY sc_char
                DELETE_CAR sc_car
                should_break = 1
            ELSE
                PRINT_HELP_STRING "Your driver is waiting for you at the marker"
                GET_CAR_COORDINATES sc_car car_x car_y car_z
                ADD_SHORT_RANGE_SPRITE_BLIP_FOR_COORD car_x car_y car_z 55 blip
                CLEAR_CHAR_TASKS_IMMEDIATELY sc_char
                WARP_CHAR_INTO_CAR sc_char sc_car
                car_stay = 1
                WHILE NOT IS_CHAR_IN_CAR sc_player sc_car
                    WAIT 0
                    GOSUB check
                    IF IS_INT_LVAR_EQUAL_TO_NUMBER should_break 1
                        should_break = 0
                        BREAK
                    ENDIF 
                    GET_CHAR_COORDINATES sc_char x y z
                    GET_CAR_COORDINATES sc_car car_x car_y car_z
                    GET_DISTANCE_BETWEEN_COORDS_3D x y z car_x car_y car_z distance

                    IF distance < 0.5
                        PRINT_HELP_STRING "Hold G to enter car as passenger"
                        IF IS_KEY_PRESSED VK_KEY_G
                            WARP_CHAR_INTO_CAR_AS_PASSENGER sc_player sc_car 1000
                        ENDIF
                    ENDIF
                ENDWHILE
                REMOVE_BLIP blip
            ENDIF
        ENDIF
    ELSE
        car_stay = 0
    ENDIF
    RETURN
}
SCRIPT_END