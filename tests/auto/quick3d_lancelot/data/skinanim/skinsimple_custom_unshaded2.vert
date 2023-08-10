VARYING vec3 varViewVec;

void MAIN()
{
    vec4 pos = (BONE_TRANSFORMS[JOINTS.x] * WEIGHTS.y + BONE_TRANSFORMS[JOINTS.y] * WEIGHTS.x)
                    * vec4(VERTEX, 1.0);
    POSITION = MODELVIEWPROJECTION_MATRIX * pos;
    varViewVec = CAMERA_POSITION - (MODEL_MATRIX * pos).xyz;
}
