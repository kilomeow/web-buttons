module Main exposing (..)

import Browser
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


type alias Model =
    List String


init = ["Meow", "Woof"]


-- Update --


type Msg
    = Update Int


update : Msg -> Model -> Model
update msg items =
    case msg of
        Update i ->
            items



-- View --


createButtons =
    List.indexedMap (\i -> \name ->
               div [ class "button"
                   , onClick (Update i) ] -- ?
                  [ text name ] )


view : Model -> Html Msg
view items =
    div
        [ ]
        [ h1 [] [ text "Control Panel" ]
        , items |> createButtons |> div [ id "panel" ]
        ]
