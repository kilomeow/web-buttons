module Main exposing (..)

import Browser
import Array exposing (Array, get, set)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


-- Model --

type ButtonType = Hold | Toggle Bool

type alias Model =
   Array ( String , ButtonType )

init = Array.fromList    [ ("Meow" , Hold)
                         , ("Woof" , Hold)
                         , ("Enable barking" , Toggle False) 
                         , ("Buzz" , Hold) ]


-- Update --


type Msg
    = Update Int


update : Msg -> Model -> Model
update msg buttons =
    case msg of
        Update i ->
            let 
                ( n , t ) = get i buttons |> Maybe.withDefault ("" , Hold)
            in
                case t of
                    Hold ->
                        buttons -- todo Cmd
                    Toggle state ->
                        set i (n, Toggle (not state)) buttons



-- View --

bclass : ButtonType -> String
bclass t = 
    case t of
        Hold -> "hold"
        Toggle False -> "toggle inactive"
        Toggle True  -> "toggle active"


createButtons =
    Array.indexedMap (\i -> \(name, t) ->
                          div [ class <| "button" ++ " " ++ (bclass t) 
                              , onClick (Update i) ] -- ?
                              [ text name ] )


view : Model -> Html Msg
view items =
    div
        [ ]
        [ h1 [] [ text "Control Panel" ]
        , items |> createButtons |> Array.toList |> div [ id "panel" ]
        ]
